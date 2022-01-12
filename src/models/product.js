const Sequelize = require('sequelize');
const sequelize = require('../db/sequelize');
const Photo = require('./photo');
const Style = require('./style');
const Sku = require('./sku');

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

// Many to many - self referencing
// https://stackoverflow.com/questions/25363782/how-to-have-a-self-referencing-many-to-many-association-in-sequelize
Product.RelatedProduct = Product.belongsToMany(Product, {as: 'related', foreignKey: 'product_id_related', through: 'product_related'});
Product.Product = Product.belongsToMany(Product, {as: 'product', foreignKey: 'product_id', through: 'product_related'});
// one to many (one product can have many photos)
Product.Photo = Product.belongsToMany(Photo, {through: 'product_photos'});
// one to many (one product can have many styles)
Product.Style = Product.belongsToMany(Style, {through: 'product_styles'});
// one to many (one product can have many skus)
Product.Sku = Product.belongsToMany(Sku, {through: 'product_skus'});

module.exports = Product;
