const express = require('express');
const app = express();
require('dotenv').config();
const products = require('./routes/products');
const path = require('path');
const cors = require('cors');
const redisClient = require('./db/redis');

// middlewares
app.use(express.json());
app.use(cors());
app.use('/', express.static(path.join(__dirname, './public')));


// routes
app.use('/products', products);

// Connect to redis and then app start listening
(async () => {
  await redisClient.connect();

  // Redis is connected
  app.listen(process.env.SERVER_PORT, () => {
    console.log(`App is running on port ${process.env.SERVER_PORT}`);
  });
}
)();


