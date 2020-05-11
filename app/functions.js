const util = require('util')

var self = module.exports = {
    formatError: (err) =>{
        console.log(err)
        let error = {success: false, messages: []}
        if (typeof err === 'string' ){
            error.messages.push(err)
        }            
        else if (err.errors !== undefined && err.errors.length){
            for(var a=0;a<err.errors.length;a++){
                error.messages.push(`${err.errors[a].message}`)
            }
        }
        else if (err.parent !== undefined && err.parent.sqlMessage !== undefined){
            error.messages.push(err.parent.sqlMessage)
        }
        else if (err.response !== undefined && err.response.data !== undefined){
            error.messages.push(err.response.data)
        }
        else{
            //console.log(err)
            error.messages.push('Unknown error')
        }
        return error
    },
    formatSuccess: (type, data, api) =>{
        let json = {success: true, message: `${type} %shas been %s`}
        let d = ''
        let str = ''
        switch (type){
            case 'Property':
            case 'Project':
                d = data.name
                break
            case 'PropertyValue':
            case 'Filter':
                d = data.label
                break
            case 'Picture':
                d = data.filename
                break
        }
        switch (api){
            case 'POST':
                str = 'added'
                break
            case 'PUT':
                str = 'updated'
                break
            case 'DELETE':
                str = 'deleted'
                break
        }
        json.message = util.format(json.message, (d != '') ? `'${d}' ` : '', str)
        return json
    }
}