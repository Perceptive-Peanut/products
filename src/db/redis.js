const Redis = require('redis');
const redisClient = Redis.createClient();

redisClient.on('connect', function() {
  console.log('Redis is Connected!');
});

redisClient.on('error', err => {
  console.log('Redis Error ' + err);
});

redisClient.on('end', () => {
  console.log('Redis disconnected');
});
redisClient.on('reconnecting', () => {
  console.log('Redis reconnecting');
});

module.exports = redisClient;