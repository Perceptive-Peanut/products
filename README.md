# Products


## node-postgres
node-postgres can be easily installed into your project by installing the pg package:
```
npm install pg
```

## Create DB and Schema
From the product root directory run:
```bash
psql postgres  < sql/product.pg.sql
```

## Extract, transform, and load data
```bash
psql postgres  < sql/etl.sql
```

## Create DB, extract, transform, and load data
```bash
psql postgres  < sql/product.pg.sql && psql postgres  < sql/etl.sql
```

## Run queries
```
psql postgres < sql/dbqueries.sql
```

## Get CSV columns
```bash
head -1 csv/product.csv # id,name,slogan,description,category,default_price
head -1 csv/photos.csv # id,styleId,url,thumbnail_url
head -1 csv/related.csv # id,current_product_id,related_product_id
head -1 csv/skus.csv # id,styleId,size,quantity
head -1 csv/styles.csv # id,productId,name,sale_price,original_price,default_style
```

## Generate queries times reports
```bash
psql postgres  < sql/queriestimes.sql  > sql/queriestimes.log
```

# K6 Install with Homebrew by running:
```
brew install k6
```
## run the saved script by executing
```
k6 run k6tests/stress.js
```
## load test with more than 1 virtual user and a slightly longer duration:
```
k6 run --vus 10 --duration 5s k6tests/stress.js
```

# Install frisby
```
npm install frisby --save-dev
```

# Install Jest
```
npm install --save-dev jest
```

## Run your tests from the CLI
```
jest
```


# PSQL
```
psql -U postgres
```

Some interesting flags (to see all, use -h or --help depending on your psql version):
```
-E: will describe the underlaying queries of the \ commands (cool for learning!)
-l: psql will list all databases and then exit (useful if the user you connect with doesn't has a default database, like at AWS RDS)
Most \d commands support additional param of __schema__.name__ and accept wildcards like *.*

\?: Show help (list of available commands with an explanation)
\q: Quit/Exit
\c __database__: Connect to a database
\d __table__: Show table definition (columns, etc.) including triggers
\d+ __table__: More detailed table definition including description and physical disk size
\l: List databases
\dy: List events
\df: List functions
\di: List indexes
\dn: List schemas
\dt *.*: List tables from all schemas (if *.* is omitted will only show SEARCH_PATH ones)
\dT+: List all data types
\dv: List views
\dx: List all extensions installed
\df+ __function__ : Show function SQL code.
\x: Pretty-format query results instead of the not-so-useful ASCII tables
\copy (SELECT * FROM __table_name__) TO 'file_path_and_name.csv' WITH CSV: Export a table as CSV
\des+: List all foreign servers
\dE[S+]: List all foreign tables
\! __bash_command__: execute __bash_command__ (e.g. \! ls)
```

User Related:
```bash
\du: List users
\du __username__: List a username if present.
create role __test1__: Create a role with an existing username.
create role __test2__ noinherit login password __passsword__;: Create a role with username and password.
set role __test__;: Change role for current session to __test__.
grant __test2__ to __test1__;: Allow __test1__ to set its role as __test2__.
\deu+: List all user mapping on server
```

## Configuration
Service management commands:
```
sudo service postgresql stop
sudo service postgresql start
sudo service postgresql restart
```

## Create command
There are many CREATE choices, like CREATE DATABASE __database_name__, CREATE TABLE __table_name__ ... Parameters differ but can be checked at the official documentation.

## Handy queries
SELECT * FROM pg_proc WHERE proname='__procedurename__': List procedure/function
SELECT * FROM pg_views WHERE viewname='__viewname__';: List view (including the definition)
SELECT pg_size_pretty(pg_total_relation_size('__table_name__'));: Show DB table space in use
SELECT pg_size_pretty(pg_database_size('__database_name__'));: Show DB space in use
show statement_timeout;: Show current user's statement timeout
SELECT * FROM pg_indexes WHERE tablename='__table_name__' AND schemaname='__schema_name__';: Show table indexes

## Get all indexes from all tables of a schema:
```
SELECT
   t.relname AS table_name,
   i.relname AS index_name,
   a.attname AS column_name
FROM
   pg_class t,
   pg_class i,
   pg_index ix,
   pg_attribute a,
    pg_namespace n
WHERE
   t.oid = ix.indrelid
   AND i.oid = ix.indexrelid
   AND a.attrelid = t.oid
   AND a.attnum = ANY(ix.indkey)
   AND t.relnamespace = n.oid
    AND n.nspname = 'kartones'
ORDER BY
   t.relname,
   i.relname
```

# Execution data:
Queries being executed at a certain DB:
```
SELECT datname, application_name, pid, backend_start, query_start, state_change, state, query
  FROM pg_stat_activity
  WHERE datname='__database_name__';
```

Get all queries from all dbs waiting for data (might be hung):
```
SELECT * FROM pg_stat_activity WHERE waiting='t'
Currently running queries with process pid:
SELECT
  pg_stat_get_backend_pid(s.backendid) AS procpid,
  pg_stat_get_backend_activity(s.backendid) AS current_query
FROM (SELECT pg_stat_get_backend_idset() AS backendid) AS s;
```

## Query analysis:
```
EXPLAIN __query__: see the query plan for the given query
EXPLAIN ANALYZE __query__: see and execute the query plan for the given query
ANALYZE [__table__]: collect statistics
```

# Deployment

1. Create a EC2 instance running Ubuntu(linux).

2. Set EC2 security groups rules(add inboud rule for HTTP).

3. Save the pem key somewhere secure in your computer and give it read permition.
```
chmod 400 aws-keypair.pem
```

4. Connect to your EC2 via SSH.
```
ssh -i "aws-keypair.pem" ubuntu@ec2-00-000-000-00.us-west-1.compute.amazonaws.com
```

5. Install EC2 dependencies.
```
sudo apt-get update && sudo apt-get upgrade -y
```

6. nginx
- Download the NGINX signing key:
```
sudo wget http://nginx.org/keys/nginx_signing.key
```
- Add the key:
```
sudo apt-key add nginx_signing.key
```
- Change directory to /etc/apt.
```
cd /etc/apt
```
- Edit the sources.list file, appending this text at the end:
```
deb http://nginx.org/packages/ubuntu focal nginx
deb-src http://nginx.org/packages/ubuntu focal nginx
```
- Update the NGINX software:
```
sudo apt-get update
```
- Install NGINX:
```
sudo apt-get install nginx
```
- Start NGINX:
```
sudo systemctl start nginx.service
```
- Check its status:
```
sudo systemctl status nginx.service
```

7. node
- download node make sure your version on your local matches the version you get
```
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
```
- install node
```
sudo apt-get install -y nodejs
```

8. Postgres - https://betterprogramming.pub/how-to-provision-a-cheap-postgresql-database-in-aws-ec2-9984ff3ddaea

```
sudo apt install postgresql -y
sudo su postgres
psql -U postgres -c "CREATE ROLE ubuntu;"
psql -U postgres -c "ALTER ROLE  ubuntu  WITH LOGIN;"
psql -U postgres -c "ALTER USER  ubuntu  CREATEDB;"
psql -U postgres -c "ALTER USER  ubuntu  WITH PASSWORD 'ubuntu';"
exit
```

9. Setup environment
```
export SERVER_PORT=3000 PGHOST=localhost PGUSER=ubuntu PGPASSWORD=ubuntu PGDATABASE=productsdb PGPORT=5432
```

9. Setup data base

- Setup database schema
```
psql postgres  < sql/product.pg.sql
```

- Copy csv data to EC2
```
scp -i <pemKey> -r ~/Projects/galvanizeNov/perceptive-peanut/products/csv ubuntu@<ec2Ipv4>:/home/ubuntu/csv
```

- Add data to database
```
psql postgres  < sql/etl.sql
```

10. Run app
```
npm start
```







