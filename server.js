// blog-api - implements a blog api with blog posts and comments
//   for edX - Introduction to NodeJS - Module 2 assignment
// server.js - application bootup
// 13 March 2018 - Ewan T.

// Imports
const express = require('express')
const logger = require('morgan')
const errorhandler = require('errorhandler')
const bodyParser = require('body-parser')
var index = require('./routes/index');

// Instantiations
let app = express()
// Set up a store for the blog and assign to the Request object so it's available in the routes
let store = {}
store.posts = []
app.request.store = store

// Middleware
app.use(bodyParser.json())
app.use(logger('dev'))
app.use(errorhandler())

// Routes
app.use('/', index);

// Server bootup
app.listen(3000)
