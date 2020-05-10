require('dotenv').config();
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
const port = process.env.PORT || 5000;

const router = express.Router();

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

router.get('/test', (req, res, next) => {  
	res.json("Connection is good.")
});

const api = require('./routes/rest/api');

app.use('/', router);
app.use('/api', api);

app.listen(port, () => console.log(`Listening on port ${port}`));