var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : '127.0.0.1',
  user     : 'jose32',
  database : 'gameday'
});

connection.connect(function(err) {
  if (err) {
    console.error('error connecting: ' + err.stack);
    return;
  }

  console.log('connected as id ' + connection.threadId);
});


//connection.connect();

var routes = require('./routes/index');
var players = require('./routes/players');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/:team/players', function(req, res){

  var team = req.params.team;
  var query = "SELECT * FROM playersummary WHERE team='" + team + "'";

  connection.query(query, function(err, rows, fields) {
    if (err) throw err;

    res.json(rows);

  });

});


app.use("/metrics", function(req, res){

  var playerId = req.body.playerId;
  var year = req.body.year;
  var selectedMetric = req.body.selectedMetric;

  //SELECT `GoodnessMetric1`, `Count`, `PitchType` FROM `dummyexampletable` WHERE `Year`=2015 AND `BatterID`=112526
  var query = "SELECT * FROM playersummary WHERE team='" + team + "' LIMIT 5";

  connection.query(query, function(err, rows, fields) {
    if (err) throw err;

    res.json(rows);

  });

});


// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
// if (app.get('env') === 'development') {
//   app.use(function(err, req, res, next) {
//     res.status(err.status || 500);
//     res.render('error', {
//       message: err.message,
//       error: err
//     });
//   });
// }

// production error handler
// no stacktraces leaked to user
// app.use(function(err, req, res, next) {
//   res.status(err.status || 500);
//   res.render('error', {
//     message: err.message,
//     error: {}
//   });
// });

app.listen(8000);

module.exports = app;
