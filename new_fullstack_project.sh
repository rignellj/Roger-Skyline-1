#!/bin/bash
npm install express body-parser
echo "const express = require('express');
const body_parser = require('body-parser');
const app = express();
app.use(body_parser.urlencoded({extended : true}));
app.get('/', function(req, res)
{
  res.send('Hello');
});
app.listen(3000, function()
{
  console.log('Server is running on port 3000.');
});" > app.js
atom .
