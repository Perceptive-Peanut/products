# Products

## Create DB and Schema
From the product root directory run:
```bash
psql postgres  < sql/product.pg.sql
```

## Add seed data to database
```bash
psql postgres  < sql/seed.sql
```

## Create DB, Add seed & clean data
```bash
psql postgres  < sql/product.pg.sql && psql postgres  < sql/seed.sql && psql postgres  < sql/update_constrains.sql
```

## Get CSV columns
```bash
head -1 csv/product.csv # id,name,slogan,description,category,default_price
head -1 csv/photos.csv # id,styleId,url,thumbnail_url
head -1 csv/related.csv # id,current_product_id,related_product_id
head -1 csv/skus.csv # id,styleId,size,quantity
head -1 csv/styles.csv # id,productId,name,sale_price,original_price,default_style
```

