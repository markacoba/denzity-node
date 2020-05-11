###Denzity App - Node

- React URL: https://vast-fortress-95457.herokuapp.com
- Node URL: https://lit-wildwood-89906.herokuapp.com
- REST API collection: https://documenter.getpostman.com/view/1636369/SzmfZdaD
- Dump of MySQL DB is in root of Node repo

###Features
- REST API to populate data
- Uses Heroku for deployment
- The test app demonstrates different data type filters for the project properties including integer, decimal ranges and string match. It also demonstrates the 3 field types in the screenshot which are select, multiple select and checkbox

###Limitations
- I did not add CSS
- No API authentication
- I only added a few properties and filters
- The Rest API has only GET and POST methods to be able fetch & populate data

As a suggestion, this filters functionality can be done in ElasticSearch. It will be very easy because projects with all its properties can be imported to only 1 ElasticSearch index and only 1 query needed for the search. Its also ideal for large amount data because its super fast.
