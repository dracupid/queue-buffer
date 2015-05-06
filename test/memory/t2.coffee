util = require './util'

util.build 'Create buffer and write data: ', ->
    x = new Buffer util.BLOCK
    x.fill 1
    x
