util = require './util'

util.build 'Create buffer, create a new buffer by slicing a small piece: ', ->
    x = new Buffer util.BLOCK
    x.fill 1
    x = new Buffer x.slice 0, 10
