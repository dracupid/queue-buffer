Benchmark = require 'benchmark'
FB = require '../src'
a = new Buffer 150
for i in [1...100]
    a[i] = 10
b = new FB 150
for i in [1...100]
    b.write 10

suite = new Benchmark.Suite()
suite.on 'start', ->
    console.log "- Read"
.add "Buffer", ->
    for i in [1...10]
        a.slice i, i + 10
.add "FlexBuffer", ->
    for i in [1...10]
        b.read 10
    b.rewind()
.on 'cycle', (e) -> console.log "    - " + e.target
.run 'async': false
