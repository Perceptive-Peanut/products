const Sequelize = require('sequelize');
const sequelize = require('../db/sequelize');
const Photo = require('./photo');
const Style = require('./style');

const productSchema = {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true,
  },
  name: {
    type: Sequelize.STRING,
    allowNull: false
  },
  campus: {
    type: Sequelize.STRING,
    allowNull: false
  },
  slogan: {
    type: Sequelize.STRING,
    allowNull: false
  },
  description: {
    type: Sequelize.STRING,
    allowNull: false
  },
  category: {
    type: Sequelize.STRING,
    allowNull: false
  },
  default_price: {
    type: Sequelize.DECIMAL,
    allowNull: false
  }
};

const Product = sequelize.define('product', productSchema);

// one to many (one product can have many photos)
Product.hasMany(Photo);
Photo.belongsTo(Product);

// one to many (one product can have many styles)
Product.hasMany(Style);
Style.belongsTo(Product);

// Many to many - self referencing
// https://stackoverflow.com/questions/25363782/how-to-have-a-self-referencing-many-to-many-association-in-sequelize
Product.RelatedProduct = Product.belongsToMany(Product, {as: 'related', foreignKey: 'product_id_related', through: 'product_related'});
Product.Product = Product.belongsToMany(Product, {as: 'product', foreignKey: 'product_id', through: 'product_related'});

module.exports = Product;
