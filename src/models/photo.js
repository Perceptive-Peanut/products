const Sequelize = require('sequelize');
const sequelize = require('../db/sequelize');

const photoSchema = {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true,
  },
  thumbnail_url: {
    type: Sequelize.STRING,
    allowNull: false
  },
  url: {
    type: Sequelize.STRING,
    allowNull: false
  }
};

const Photo = sequelize.define('photo', photoSchema);

module.exports = Photo;
