const express = require('express');
const app = express();
require('dotenv').config();
const products = require('./routes/products');
const path = require('path');

// middlewares
app.use(express.json());
app.use('/', express.static(path.join(__dirname, './public')));
// app.get('/', function(req, res) {
//   res.sendFile(path.join(__dirname, './public/loaderio-e309a817310c5b846919bd250e24b11c.txt'));
// });

// routes
app.use('/products', products);

app.listen(process.env.SERVER_PORT, () => {
  console.log(`App is running on port ${process.env.SERVER_PORT}`);
});
