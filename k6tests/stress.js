import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '2m', target: 100 }, // below normal load
    { duration: '5m', target: 100 },
    { duration: '2m', target: 200 }, // normal load
    { duration: '5m', target: 200 },
    { duration: '2m', target: 300 }, // around the breaking point
    { duration: '5m', target: 300 },
    { duration: '2m', target: 400 }, // beyond the breaking point
    { duration: '5m', target: 400 },
    { duration: '10m', target: 0 }, // scale down. Recovery stage.
  ],
};

export default function () {
  check(http.get('http://localhost:3000/products'), { 'status was 200': (r) => r.status == 200 });
  sleep(1);
  check(http.get('http://localhost:3000/products/123'), { 'status was 200': (r) => r.status == 200 });
  sleep(1);
  check(http.get('http://localhost:3000/products/123/styles'), { 'status was 200': (r) => r.status == 200 });
  sleep(1);
  check(http.get('http://localhost:3000/products/123/related'), { 'status was 200': (r) => r.status == 200 });
  sleep(1);
}
