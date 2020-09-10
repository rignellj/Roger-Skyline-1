#!/bin/bash
npm install express body-parser mongoose ejs lodash
echo "const express = require('express');
const body_parser = require('body-parser');
const mongoose = require('mongoose');
const _ = require('lodash');
const ejs = require('ejs');
const app = express();

app.set('view engine', 'ejs');
app.use(body_parser.urlencoded({extended : true}));
app.use(express.static("public"));

app.get('/', function(req, res)
{
  res.send('Hello');
});

app.listen(3000, function()
{
  console.log('Server is running on port 3000.');
});" > app.js
mkdir -p views/partials
touch views/partials/{footer.ejs,header.ejs}
touch views/home.ejs
echo "/node_modules
npm-debug.log
.DS_Store
/*.env" > .gitignore
echo "web: node app.js" > Procfile
nodemon app.js
atom .
