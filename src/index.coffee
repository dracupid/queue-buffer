"use strict"

FlexBuffer = require 'flex-buffer'
{QueueDelayError, QueueReadError} = require './Error'

class QueueBuffer extends FlexBuffer
    ###*
     * Auto release threshold(ms)
     * @type {number}
     * @prefix QueueBuffer.
    ###
    @AUTO_RELEASE_THRESHOLD: 20 * 1024 * 1024 # 20M

    ###*
     * see [FlexBuffer](https://github.com/dracupid/flex-buffer#constructorarg-opts--)
     * @param  {number | Buffer | Array | string} arg   The same arg as Buffer.
     * @param  {Object={}} opts                         options
     * @option {boolean} autoRelease auto       release useless space
     * @option {number} autoReleaseThreshold    auto release threshold(ms)
    ###
    constructor: (arg, opt = {}) ->
        @autoRelease = if opt.autoRelease? then opt.autoRelease else true
        @AUTO_RELEASE_THRESHOLD = opt.autoReleaseThreshold or QueueBuffer.AUTO_RELEASE_THRESHOLD
        @_readOffset = 0
        @_freeTime = 0
        super
        @

    ###*
     * Release useless space which has been read.
     * @param
    ###
    free: ->
        @_freeTime += 1
        @_buffer = new Buffer @_buffer.slice @_readOffset
        @_writeOffset -= @_readOffset
        @_readOffset = 0

    _freeIfRequired: ->
        if @autoRelease and @_readOffset >= @AUTO_RELEASE_THRESHOLD
            @free()

    ###*
     * overwrite
     * @nodoc
    ###
    flush: ->
        @_readOffset = 0
        super

    ###*
     * overwrite
     * @nodoc
    ###
    slice: (start = 0, end = @length, newBuffer = false) ->
        start += @_readOffset
        end += @_readOffset
        super start, end, newBuffer

    ###*
     * overwrite
     * @nodoc
    ###
    inspect: ->
        """
        [QueueBuffer]
            length: #{@length},
            bufferLength: #{@bufferLength}
            head: #{@_readOffset}
            tail: #{@_writeOffset}
            _resizeTime: #{@_resizeTime}
            _freeTime: #{@_freeTime}
            _buffer: #{@_buffer.inspect()}
        """

    ###*
     * Move current read offset.
     * @param  {number} size    number of bytes to move, can be negative.
    ###
    move: (size) ->
        if @_readOffset + size >= 0 and size <= @length
            @_readOffset += ~~size
        else
            throw new QueueReadError "Move out of the block content.(Cur: #{@_readOffset}; Remain: #{@length}; Move: #{size})"

    ###*
     * Move current read offset forward.
     * @param  {number} size    number of bytes to skip
    ###
    skip: (size) ->
        if size >= 0
            @move size
        else
            throw new QueueReadError "Can only skip forward. (Try to skip #{size} bytes.)"

    ###*
     * Move current read offset backward.
     * @param  {number} size    number of bytes to rewind
    ###
    rewind: (size) ->
        if size?
            if size >= 0
                @move -size
            else
                throw new QueueReadError "Can only rewind backward. (Try to rewind #{size} bytes.)"
        else
            @_readOffset = 0

    _readAssert: (size) ->
        if @_readOffset + size > @_buffer.length
            throw new QueueReadError "Read out of the buffer. (Read: #{size}; Offset: #{@_readOffset}; BufferSize: #{@_buffer.length})"
        else if size > @length
            # cauch it
            throw new QueueDelayError "No enough bytes to be read. (Reauired: #{size}; Remaining: #{@length})"

    ###*
     * Read bytes from the head of the buffer.
     * @param  {number} size  number of bytes to read
     * @return {Buffer}       data
     * @alias unshift, dequeue
    ###
    read: (size) ->
        size >>>= 0

        if size is 0
            new Buffer 0
        else
            @_readAssert size
            buf = @_buffer.slice @_readOffset, @_readOffset + size
            @_readOffset += size
            @_freeIfRequired()
            buf


    enqueue: QueueBuffer::write
    push: QueueBuffer::write
    dequeue: QueueBuffer::read
    unshift: QueueBuffer::read

###*
 * see [FlexBuffer](https://github.com/dracupid/flex-buffer#writevalue-encoding--utf8)
 * @param  {number | string | Array | Buffer}  value     The value to write
 * @param  {string="utf8"}                     encoding  string encoding
 * @alias push, enqueue
###
write = ''


Object.defineProperties QueueBuffer::,
    ###*
     * length of the data
     * @type {number}
    ###
    'length':
        get: -> @_writeOffset - @_readOffset

# Extend native Buffer API

_readerBuilder = (len, k, v) ->
    QueueBuffer::[k] = ->
        @_readAssert len
        res = v.call @_buffer, @_readOffset, false
        @_readOffset += len
        @_freeIfRequired()

        res

for k, v of Buffer::
    if k.indexOf('read') is 0
        do (k, v) ->
            arr = k.match /\d+/
            if arr and arr[0]
                _readerBuilder.call @, arr[0] / 8, k, v
            else if /Double/.test k
                _readerBuilder.call @, 8, k, v
            else if /Float/.test k
                _readerBuilder.call @, 4, k, v
            else
                QueueBuffer::[k] = (byteLength) ->
                    @_readAssert byteLength
                    res = v.call @_buffer, @_readOffset, byteLength, false
                    @_readOffset += byteLength
                    @_freeIfRequired()

                    res

module.exports = QueueBuffer
