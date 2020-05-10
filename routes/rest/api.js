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

 module.exports = router