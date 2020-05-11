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
    label: {
        type: DataTypes.STRING,
        allowNull: false
    },    
    type: {
        type: DataTypes.ENUM('string', 'integer', 'decimal'),    
        defaultValue: 'string',
        allowNull: false
    },
    active: {
        type: DataTypes.BOOLEAN,         
        defaultValue: true
    }
}, { sequelize, modelName: 'properties' })

class PropertyStringValue extends Model {}
PropertyStringValue.init({
    label: {
        type: DataTypes.STRING,
        allowNull: false
    },
    value: {
        type: DataTypes.STRING,
        allowNull: false
    }
}, { sequelize, modelName: 'propertyStringValues' })

class PropertyIntegerValue extends Model {}
PropertyIntegerValue.init({
    label: {
        type: DataTypes.STRING,
        allowNull: false
    },
    value: {
        type: DataTypes.INTEGER,
        allowNull: false
    }
}, { sequelize, modelName: 'propertyIntegerValues' })

class PropertyDecimalValue extends Model {}
PropertyDecimalValue.init({
    label: {
        type: DataTypes.STRING,
        allowNull: false
    },
    value: {
        type: DataTypes.DECIMAL,
        allowNull: false
    }
}, { sequelize, modelName: 'propertyDecimalValues' })

class Filter extends Model {}
Filter.init({
    label: {
        type: DataTypes.STRING,       
        unique: true,  
        allowNull: false
    },
    type: {
        type: DataTypes.ENUM('option', 'float-range', 'integer-range'),    
        defaultValue: 'option',
        allowNull: false
    },
    fieldType: {
        type: DataTypes.ENUM('dropdown', 'dropdown-multiple', 'checkbox'),    
        defaultValue: 'dropdown'
    },
    sort: {
        type: DataTypes.INTEGER,         
        allowNull: false,
        defaultValue: 99
    },
    dynamicOptions: {
        type: DataTypes.BOOLEAN,         
        defaultValue: true
    },
    active: {
        type: DataTypes.BOOLEAN,         
        defaultValue: true
    }
}, { sequelize, modelName: 'filters' })

Property.hasMany(Filter)
Filter.belongsTo(Property)

class FilterOption extends Model {}
FilterOption.init({
    label: {
        type: DataTypes.STRING,       
        unique: true,  
        allowNull: false
    },
    value: {
        type: DataTypes.STRING,         
        allowNull: false
    },
    sort: {
        type: DataTypes.INTEGER,         
        allowNull: false,
        defaultValue: 99
    },
    active: {
        type: DataTypes.BOOLEAN,         
        defaultValue: true
    }
}, { sequelize, modelName: 'filterOptions' })

Filter.hasMany(FilterOption)
FilterOption.belongsTo(Filter)

class Project extends Model {}
Project.init({
    name: {
        type: DataTypes.STRING,       
        unique: true,  
        allowNull: false
    },
    active: {
        type: DataTypes.BOOLEAN,         
        defaultValue: true
    },
    startDate: {
        type: DataTypes.DATEONLY
    },
    endDate: {
        type: DataTypes.DATEONLY
    }
}, { sequelize, modelName: 'projects' })

class Picture extends Model {}
Picture.init({
    filename: {
        type: DataTypes.STRING,       
        unique: true,  
        allowNull: false
    }
}, { sequelize, modelName: 'pictures' })

Project.hasMany(Picture)
Picture.belongsTo(Project)

Property.hasMany(PropertyStringValue)
Project.hasMany(PropertyStringValue)
PropertyStringValue.belongsTo(Property)
PropertyStringValue.belongsTo(Project)

Property.hasMany(PropertyIntegerValue)
Project.hasMany(PropertyIntegerValue)
PropertyIntegerValue.belongsTo(Property)
PropertyIntegerValue.belongsTo(Project)

Property.hasMany(PropertyDecimalValue)
Project.hasMany(PropertyDecimalValue)
PropertyDecimalValue.belongsTo(Property)
PropertyDecimalValue.belongsTo(Project)

sequelize.sync()

module.exports = {
    Property: Property,
    Filter: Filter,
    FilterOption: FilterOption,
    Project: Project,
    Picture: Picture,
    PropertyStringValue: PropertyStringValue,
    PropertyIntegerValue: PropertyIntegerValue,
    PropertyDecimalValue: PropertyDecimalValue
}