util = require './util'

util.build 'Create buffer, slice a small piece: ', ->
    x = new Buffer util.BLOCK
    x.fill 1
    x = x.slice 0, 10
