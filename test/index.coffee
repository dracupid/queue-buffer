require './flex-buffer'
QB = require '../src'
assert = require 'assert'
util = require 'util'

eq = assert.strictEqual
deq = assert.deepStrictEqual or assert.deepEqual
ts = assert.throws

testBuf = new Buffer 1

describe "read data", ->
    it "read existed data", ->
        buf = new QB 10
        buf.write [1, 2, 3, 4, 5, 6, 7]
        deq buf.read(3), new Buffer [1, 2, 3]
        eq buf.length, 4
        deq buf.read(3), new Buffer [4, 5, 6]
        eq buf.length, 1
    it "can read 0 as Buffer(0)", ->
        buf = new QB [1, 2, 3, 4, 5, 6, 7]
        deq buf.read(0), new Buffer 0
    it "can detect range error", ->
        buf = new QB 10
        buf.write [1, 2, 3, 4, 5, 6, 7]
        ts -> buf.read 15
        ts -> buf.read 8

describe "convert", ->
    it '#slice', ->
        buf = new QB 10
        buf.write [1, 2, 3, 4, 5]
        buf.read 3
        eq buf.length, 2
        deq buf.slice(0, 1), new Buffer [4]

    it '#toBuffer', ->
        buf = new QB 10
        buf.write [1, 2, 3, 4, 5]
        buf.read 3
        deq buf.toBuffer(), new Buffer [4, 5]

    it '#toString', ->
        buf = new QB "ABDACD"
        buf.read 2
        eq buf.toString(), "DACD"

describe "free space", ->
    it "force free", ->
        buf = new QB 100
        buf.write [1..50]
        buf.read 30
        eq buf.length, 20
        eq buf.bufferLength, 100
        eq buf._readOffset, 30
        buf.free()
        eq buf.length, 20
        eq buf.bufferLength, 70
        eq buf._readOffset, 0
    it "auto free", ->
        buf = new QB 100, autoReleaseThreshold: 15
        buf.write [1..50]
        buf.read 30
        eq buf.length, 20
        eq buf.bufferLength, 70
        eq buf._readOffset, 0


describe "extended Buffer util API", ->
    if testBuf.equals
        it '#equals', ->
            buf = new QB "asdsd"
            buf.read 2
            assert buf.equals new Buffer "dsd"
    if testBuf.indexOf
        it '#indexOf', ->
            buf = new QB "asdsd"
            buf.read 2
            eq 0, buf.indexOf 'd'

describe "extended Buffer write API", ->
    it '#readInt32LE', ->
        buf = new QB 4
        buf.writeInt32LE 1
        eq buf.readInt32LE(), 1
        eq buf.length, 0

    if testBuf.equals
        it '#readUIntLE', ->
            buf = new QB 10
            buf.writeUIntLE 1, 3
            eq 1, buf.readUIntLE 3
            eq 0, buf.length

    it '#read in sequence', ->
        buf = new QB 8
        eq 2, buf.writeInt16LE 123
        eq 4, buf.writeFloatLE 123
        eq 8, buf.writeDoubleBE 21343.4123

        eq buf.readInt16LE(), 123
        eq buf.readFloatLE(), 123
        eq buf.readDoubleBE(), 21343.4123

        eq 0, buf.length
