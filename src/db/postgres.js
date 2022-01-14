const { Client } = require('pg');

const { PGUSER, PGPASSWORD, PGHOST, PGPORT, PGDATABASE } = process.env;

const db = new Client({
  host: PGHOST,
  port: PGPORT,
  user: PGUSER,
  password: PGPASSWORD,
  database: PGDATABASE,
});

db.connect()
  .then(() => console.log('connected'))
  .catch(err => console.error('connection error', err.stack))

module.exports = db;
