const express = require('express');
const app = express();
require('dotenv').config();
const products = require('./routes/products');

// middlewares
app.use(express.json());

// routes
app.use('/products', products);

app.listen(process.env.SERVER_PORT, () => {
  console.log(`App is running on port ${process.env.SERVER_PORT}`);
});
