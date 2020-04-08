  
const express = require('express');
const api = express.Router();
const db = require('../db-function');
const bodyParser = require('body-parser')
module.exports = api;

api.use(bodyParser.json());
api.use(bodyParser.urlencoded({ extended: true }));