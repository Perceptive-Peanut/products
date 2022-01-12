const mongoose = require('mongoose');
const { MONGODB_HOST, MONGODB_DB } = process.env;

mongoose.connect(`${MONGODB_HOST}/${MONGODB_DB}`);
