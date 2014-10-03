class Api
  constructor: (@app) ->

    # @app.get '/api/stuff', @getStuff

  
  # getStuff: (req, res, next) ->
  #   Stuff.find req.query, (err, docs) ->
  #     return res.send 500, err if err
  #     res.json docs 

module.exports = (app) -> new Api app