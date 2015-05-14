"use strict"

{format} = require "util"

class QueueDelayError extends Error
    constructor: ->
        @name = 'QueueDelayError'
        @message = format.apply null, arguments
        Error.captureStackTrace @, @constructor

class QueueReadError extends Error
    constructor: ->
        @name = 'QueueReadError'
        @message = format.apply null, arguments
        Error.captureStackTrace @, @constructor

module.exports = {
    QueueDelayError
    QueueReadError
}
