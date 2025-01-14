const express = require('express');
const cookieParser = require('cookie-parser');
const serverLog = require('easy-log');
const cors = require('cors');

const app = express();

app.use((req, res, next) => {
  serverLog(`${req.method} - ${req.originalUrl}`)
  next()
})

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(cors())

app.get('/', (req, res, next) => {
  res.send('Hello World')
})

module.exports = app;
