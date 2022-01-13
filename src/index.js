const express = require('express');
require('dotenv').config();
const app = express();
const sequelize = require('./db/sequelize');

// models
const Product = require('./models/product');

// force db update
sequelize.sync({force: true});

app.listen(process.env.PORT, () => {
  console.log(`App is running on port ${process.env.PORT}`);
});