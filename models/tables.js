require('dotenv').config()
const { Sequelize, Model, DataTypes } = require('sequelize')

const sequelize = new Sequelize(process.env.MYSQL_DB, process.env.MYSQL_USERNAME, process.env.MYSQL_PASSWORD, {
    host: process.env.MYSQL_SERVER,
    dialect: 'mysql',
    logging: false
})

class Property extends Model {}
Property.init({
    name: {
        type: DataTypes.STRING,       
        unique: true,  
        allowNull: false
    },
    filterLabel: {
        type: DataTypes.STRING
    },   
    type: {
        type: DataTypes.STRING,         
        allowNull: false
    },    
    sort: {
        type: DataTypes.STRING,         
        allowNull: false,
        defaultValue: 100
    }
}, { sequelize, modelName: 'Properties' })

sequelize.sync()
module.exports = {
    Property: Property
}