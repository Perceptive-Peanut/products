const frisby = require('frisby');

it('/products', function () {
  return frisby.get('http://localhost:3000/products')
    .expect('status', 200);
});

it('/products/:id', function () {
  return frisby.get('http://localhost:3000/products/1')
    .expect('status', 200);
});

it('/products/:id/styles', function () {
  return frisby.get('http://localhost:3000/products/1/styles')
    .expect('status', 200);
});

it('/products/:id/related', function () {
  return frisby.get('http://localhost:3000/products/1/related')
    .expect('status', 200);
});
