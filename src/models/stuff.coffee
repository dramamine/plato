mongoose = require 'mongoose'

StuffSchema = mongoose.Schema

  # content: String
  # active: Boolean

module.exports = mongoose.model 'Stuff', StuffSchema