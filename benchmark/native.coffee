Benchmark = require 'benchmark'
FB = require '../src'
a = new Buffer 20
a.writeDoubleLE 10.10, 0
a.writeInt32LE 19, 8

b = new FB 20, autoRelease: false
b.writeDoubleLE 10.10
b.writeInt32LE 19

suite = new Benchmark.Suite()
suite.on 'start', ->
    console.log "- wrapped native API"
.add "Buffer", ->
    a.readDoubleLE 0
    a.readInt32LE 8
.add "FlexBuffer", ->
    b.readDoubleLE()
    b.readInt32LE()
    b.rewind()
.on 'cycle', (e) -> console.log "    - " + e.target
.run 'async': false
