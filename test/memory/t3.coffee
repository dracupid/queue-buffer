util = require './util'

util.build 'Create buffer and set null: ', ->
    x = new Buffer util.BLOCK
    x.fill 1
    x = null
