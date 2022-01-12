const Sequelize = require('sequelize');
// destructuring the values from process.env
const { MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD, MYSQL_HOST_IP } = process.env;

// saving connection to db to a variable
const sequelize = new Sequelize(MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD, {
  dialect: 'mysql',
  host: MYSQL_HOST_IP
});

module.exports = sequelize;
