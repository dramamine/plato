express = require 'express'
require 'coffee-script'
require 'jade'
path = require 'path'
harp = require 'harp'

# these get app.locals working some magic, I guess
util = require 'util'
tp = require 'tea-properties'
df = require 'dateformat'

app = express()

app.configure ->
  app.set 'views', __dirname + '/views'
  app.locals.basedir = app.get 'views'
  app.set 'view engine', 'jade'
  app.locals.pretty = true

  # connect to our db
  mongoose = require './db/db.coffee'

  # put everything you 'use' in here!
  # middleware = [

  # ]
  # app.use m for m in middleware
  
  app.use '/', express.static path.resolve __dirname, '../public'
  app.use '/', harp.mount path.resolve __dirname, '../public'
  app.use 'favicon', path.resolve __dirname, '../public/favicon.ico'

  app.locals
    get: (obj, loc, def = undefined) -> tp.get(obj, loc) ? def
    inspect: util.inspect
    df: df


app.configure 'development', ->
  app.use express.errorHandler {dumpExceptions: true, showStack: true}
  app.locals.pretty = true
  app.set 'domain', 'localhost'
  app.set 'port', 3000

app.configure 'production', ->
  app.use express.errorHandler()
  app.set 'domain', 'metal-heart.org'
  app.set 'port', 80

# get some frackin routes
require('./routes') app

app.listen (app.get 'port'), (app.get 'domain')
console.log "Listening to #{app.get 'domain'}:#{app.get 'port'}"

module.exports = app


