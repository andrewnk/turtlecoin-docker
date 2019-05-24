'use strict'

const winston = require('winston')
const colorizer = winston.format.colorize()

module.exports = winston.createLogger({
  level: 'debug',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.simple(),
    winston.format.printf(msg => colorizer.colorize(msg.level, `${msg.timestamp}: [${msg.level}]: ${msg.message}`))
  ),
  transports: [
    new winston.transports.Console()
  ]
})
