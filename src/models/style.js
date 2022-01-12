const Sequelize = require('sequelize');
const sequelize = require('../db/sequelize');

const styleSchema = {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true,
  },
  name: {
    type: Sequelize.STRING,
    allowNull: false
  }
};

const Style = sequelize.define('style', styleSchema);

module.exports = Style;
