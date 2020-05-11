require('dotenv').config();
const express = require('express');
const router = express.Router();
const models = require('../../models/tables')
const func = require('../../app/functions')

const { Sequelize, Model, DataTypes } = require('sequelize')
const Op = Sequelize.Op

router.get('/property', (req, res) => {
	new Promise((resolve, reject) =>{
		models.Property.findAll({order: [['name', 'ASC']]}).then(async m =>{
			res.json({success: true, results: m})
		})
		.catch(err => reject(func.formatError(err)))
	})
	.catch(err=> res.json(err))
})

router.post('/property', (req, res) => {
	new Promise((resolve, reject) =>{
		models.Property.create(req.body).then(m =>{
			resolve(m)
		})
		.catch(err => reject(func.formatError(err)))
	}).then(m=>{
		res.json(func.formatSuccess('Property', m, req.method))
	})
	.catch(err=> res.json(err))
})

router.get('/project', (req, res) => {
	new Promise((resolve, reject) =>{
		models.Project.findAll({
			where: {active: true}, // add startDate & endDate logic here
			order: [['name', 'ASC']]
		}).then(async m =>{
			res.json({success: true, results: m})
		})
		.catch(err => reject(func.formatError(err)))
	})
	.catch(err=> res.json(err))
})

router.post('/project', (req, res) => {
	new Promise((resolve, reject) =>{
		models.Project.create(req.body).then(m =>{
			resolve(m)
		})
		.catch(err => reject(func.formatError(err)))
	}).then(m=>{
		res.json(func.formatSuccess('Project', m, req.method))
	})
	.catch(err=> res.json(err))
})

router.post('/picture/:projectId', (req, res) => {
	const projectId = req.params.projectId
	new Promise((resolve, reject) =>{
		req.body.projectId = projectId
		models.Picture.create(req.body).then(m =>{
			resolve(m)
		})
		.catch(err => reject(func.formatError(err)))
	}).then(m=>{
		res.json(func.formatSuccess('Picture', m, req.method))
	})
	.catch(err=> res.json(err))
})

router.get('/filter', (req, res) => {
	new Promise((resolve, reject) =>{
		models.Filter.findAll({
			where: {active: true},
			order: [['sort', 'ASC']],
			raw: true
		}).then(async m =>{
			let arr = []
			for (var a=0; a<m.length; a++){
				let f = m[a]
				if (f.dynamicOptions){
					const table = models.PropertyStringValue
					const property = await models.Property.findOne({where: {id: f.propertyId}})
					switch (property.type){
						case 'integer':
							table = models.PropertyIntegerValue
							break
						case  'decimal':
							table = models.PropertyDecimalValue
							break
					}
					const values = await table.findAll({
						where: {propertyId: property.id},
						order: [['label', 'asc']],
						group: ['value']
					})
					f.options = values
				}
				else{
					const options = await models.FilterOption.findAll({where: {filterId: f.id, active: true}, order: [['sort', 'ASC']]})
					f.options = options
				}
				arr.push(f)
			}
			res.json({success: true, results: arr})
		})
		.catch(err => reject(func.formatError(err)))
	})
	.catch(err=> res.json(err))
})

router.post('/filter/:propertyId', (req, res) => {
	const propertyId = req.params.propertyId
	new Promise(async (resolve, reject) =>{
		const property = await models.Property.findOne({where: {id: propertyId}})

		if (property === null) 
			reject(func.formatError(`Property #${propertyId} not found`))

		req.body.propertyId = propertyId
		models.Filter.create(req.body).then(m =>{
			resolve(m)
		})
		.catch(err => reject(func.formatError(err)))
	}).then(m=>{
		res.json(func.formatSuccess('Filter', m, req.method))
	})
	.catch(err=> res.json(err))
})

router.get('/project-properties/:projectId', (req, res) => {
	const id = req.params.projectId
	new Promise(async (resolve, reject) =>{
		const strings = await models.PropertyStringValue.findAll({where: {projectId: id}, include: models.Property})
		const integers = await models.PropertyIntegerValue.findAll({where: {projectId: id}, include: models.Property})
		const decimals = await models.PropertyDecimalValue.findAll({where: {projectId: id}, include: models.Property})

		let arr = strings.concat(integers).concat(decimals)
		res.json({success: true, results: arr})
	})
	.catch(err=> res.json(err))
})

router.post('/project-property/:projectId/:propertyId', (req, res) => {
	const projectId = req.params.projectId
	const propertyId = req.params.propertyId
	new Promise(async (resolve, reject) =>{
		const property = await models.Property.findOne({where: {id: propertyId}})
		const project = await models.Project.findOne({where: {id: projectId}})

		if (project === null) 
			reject(func.formatError(`Project #${projectId} not found`))
		if (property === null) 
			reject(func.formatError(`Property #${propertyId} not found`))

		let table = models.PropertyStringValue
		switch (property.type){
			case 'integer':
				table = models.PropertyIntegerValue
				break
			case  'decimal':
				table = models.PropertyDecimalValue
				break
		}
		req.body.projectId = projectId
		req.body.propertyId = propertyId
		table.create(req.body).then(m =>{
			resolve(m)
		})
		.catch(err => reject(func.formatError(err)))
	}).then(m=>{
		res.json(func.formatSuccess('PropertyValue', m, req.method))
	})
	.catch(err=> res.json(err))
})

async function getResults(ands, projectIdsArr, table){
	if (projectIdsArr.length)
		ands.push({projectId: {[Op.in]: projectIdsArr}})

	const data = await table.findAll({
		where: {[Op.and]: [ands]}, 
		include: [{
			model: models.Project, required: true
		}],
		group: ['project.id']
	})
	return data
}
router.post('/project-property/filter', (req, res) => {
	new Promise(async (resolve, reject) =>{
		const body = req.body
		let arr = []
		let tables = {}
		for (var key in body){
			const filterId = parseInt(key)
			const filter = await models.Filter.findOne({where: {id: filterId}, include:[
				{ model: models.Property, required: true }
			]})
			if (filter !== null){

				const propertyId = filter.propertyId		
				for (var value in body[key]){
					if (body[key][value] == true){			
						if (tables[filter.property.type] === undefined){
							tables[filter.property.type] = {}
							tables[filter.property.type][propertyId] = {filterType: filter.type, values: [value]}
						}
						else{
							if (tables[filter.property.type][propertyId] === undefined){
								tables[filter.property.type][propertyId] = {filterType: filter.type, values: [value]}
							}
							else{
								if (tables[filter.property.type][propertyId].values.indexOf(value) < 0){
									tables[filter.property.type][propertyId].values.push(value)	
								}
							}
						}						
					}
				}
			}
		}
		//console.log(tables)
		let projectIdsArr = []
		if (Object.keys(tables).length){
			let count = 0
			for (var key in tables){
				
				let table = models.PropertyStringValue
				if (key == 'string'){
					for (var propertyId in tables[key]){
						let ands = []	
						//console.log(tables[key][propertyId].values)
						ands.push({propertyId: parseInt(propertyId), value: {[Op.in]: tables[key][propertyId].values}})
						let data = await getResults(ands,projectIdsArr,table)
						if (data.length){
							let ids = []
							for (var a=0; a <data.length; a++){
								if (ids.indexOf(data[a].project.id) < 0){
									ids.push(data[a].project.id)
								}
								projectIdsArr = ids		
							}
						}
						else resolve([])				
					}
				}
				else if (key == 'decimal' || key == 'integer'){
					table = (key == 'decimal') ? models.PropertyDecimalValue : models.PropertyIntegerValue
					for (var propertyId in tables[key]){
						let ands = []	
						if (tables[key][propertyId].filterType == 'float-range' || tables[key][propertyId].filterType == 'integer-range'){
							for (var b=0; b <tables[key][propertyId].values.length; b++){
								let range = tables[key][propertyId].values[b].split('-')
								range[0] = parseFloat(range[0])
								range[1] = parseFloat(range[1])
								if (range.length == 2){
									ands.push({propertyId: parseInt(propertyId), value: {[Op.between]: range}})
									let data = await getResults(ands,projectIdsArr,table)
									if (data.length){
										let ids = []
										for (var a=0; a <data.length; a++){
											if (ids.indexOf(data[a].project.id) < 0){
												ids.push(data[a].project.id)
											}
											projectIdsArr = ids		
										}
									}
									else resolve([])								
								}
							}
						}
					}				
				}

				count++				
			}
		}
		resolve(projectIdsArr)
	})
	.then(async arr =>{
		if (arr.length){
			const projects = await models.Project.findAll({
				where: {id: {[Op.in]:arr} },
				include: [
					{model: models.PropertyStringValue, include: [{model: models.Property}]}, 
					{model: models.PropertyIntegerValue, include: [{model: models.Property}]}, 
					{model: models.PropertyDecimalValue, include: [{model: models.Property}]},
					{model: models.Picture}
				]				
			})
			res.json({success: true, results: projects})
		}
		else{
			res.json({success: true, results: []})
		}
		
	})
	.catch(err=> res.json(err))
})

module.exports = router