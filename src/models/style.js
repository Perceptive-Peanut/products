const Sequelize = require('sequelize');
const sequelize = require('../db/sequelize');
const Sku = require('./sku');

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

// one to one (one style can have one sku)
Style.hasOne(Sku);
Sku.belongsTo(Style);

module.exports = Style;
