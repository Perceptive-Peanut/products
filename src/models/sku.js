const Sequelize = require('sequelize');
const sequelize = require('../db/sequelize');

const skuSchema = {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true,
  },
  quantity: {
    type: Sequelize.INTEGER,
    allowNull: false
  },
  size: {
    type: Sequelize.STRING,
    allowNull: false
  }
};

const Sku = sequelize.define('sku', skuSchema);

module.exports = Sku;
