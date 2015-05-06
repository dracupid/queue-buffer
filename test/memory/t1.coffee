util = require './util'

util.build 'Create buffer(no write): ', ->
    x = new Buffer util.BLOCK
