const mongoose = require('mongoose');

const photoSchema = mongoose.Schema({
  thumbnail_url: String,
  url: String
});

const Photo = mongoose.model('photo', photoSchema);

module.exports = Photo;
