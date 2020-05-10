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
		switch (project.type){
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

router.post('/project-property/filter', (req, res) => {
	new Promise(async (resolve, reject) =>{
		const body = req.body
		res.json({success: true, results: arr})
	})
	.catch(err=> res.json(err))
})

module.exports = router