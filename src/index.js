const express = require('express');
require('dotenv').config();
const app = express();
const mongoose = require('mongoose');
require('./db/mongoose');

// models
const Product = require('./models/product');
// const Style = require('./models/style');
// const Photo = require('./models/photo');
// const Sku = require('./models/sku');


app.listen(process.env.PORT, () => {
  console.log(`App is running on port ${process.env.PORT}`);
});
