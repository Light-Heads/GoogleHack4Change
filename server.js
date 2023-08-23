const express = require('express');
const mongoDB = require('./database/mongo.database.js');
const cors = require('cors');
const bodyParser = require('body-parser');
const routes = require('./routes/routes.js');

const app = express();
const port = 3000 || process.env.PORT;

mongoDB();

app.get('/', (req, res) => res.send('Hello World!'));

app.use(cors());
app.use(express.json());
app.use(bodyParser.json());

app.use(routes);

app.listen(port, () => console.log(`Example app listening on port ${port}!`));

