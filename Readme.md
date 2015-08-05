Queue-Buffer
===================
A flex buffer which behaves as a dynamic queue with a complete but limited Buffer API.
- Queue-Buffer extends [Flex-Buffer](https://github.com/dracupid/flex-buffer).
- Tested on Node 0.8-0.12, latest iojs on Mac, Linux and Windows.
- Entities in the queue are kept in order and the only operations on the collection are the addition of entities to the rear terminal position, known as enqueue(write), and removal of entities from the front terminal position, known as dequeue(read).

[![NPM version](https://badge.fury.io/js/queue-buffer.svg)](https://www.npmjs.com/package/queue-buffer)
[![Build Status](https://travis-ci.org/dracupid/queue-buffer.svg)](https://travis-ci.org/dracupid/queue-buffer)
[![Build status](https://ci.appveyor.com/api/projects/status/github/dracupid/queue-buffer?svg=true)](https://ci.appveyor.com/project/dracupid/queue-buffer)


## Quick Start
```
npm install queue-buffer -S
```
then
```javascript
QueueBuffer = require("queue-buffer");

buf = new QueueBuffer(10);
buf.write([1, 2, 3, 4, 5]);
buf.writeInt32LE(14);
buf.read(5);
```

## API
QueueBuffer extends Flexbuffer, please see [Flex-Buffer](https://github.com/dracupid/flex-buffer#api) for more API info.



- #### <a href="./src/index.coffee?source#L12" target="_blank"><b>QueueBuffer.AUTO\_RELEASE_THRESHOLD </b></a>
    Auto release threshold(ms)

  - **type**:  { _number_ }

- #### <a href="./src/index.coffee?source#L21" target="_blank"><b>constructor (arg, opts = {})</b></a>
    see [FlexBuffer](https://github.com/dracupid/flex-buffer#constructorarg-opts--)

  - **param**: `arg` { _number | Buffer | Array | string_ }

    The same arg as Buffer.

  - **param**: `opts` { _Object={}_ }

    options

  - **option**: `autoRelease` { _boolean_ }

    auto       release useless space

  - **option**: `autoReleaseThreshold` { _number_ }

    auto release threshold(ms)

- #### <a href="./src/index.coffee?source#L33" target="_blank"><b>free ()</b></a>
    Release useless space which has been read.

- #### <a href="./src/index.coffee?source#L80" target="_blank"><b>move (size)</b></a>
    Move current read offset.

  - **param**: `size` { _number_ }

    number of bytes to move, can be negative.

- #### <a href="./src/index.coffee?source#L90" target="_blank"><b>skip (size)</b></a>
    Move current read offset forward.

  - **param**: `size` { _number_ }

    number of bytes to skip

- #### <a href="./src/index.coffee?source#L100" target="_blank"><b>rewind (size)</b></a>
    Move current read offset backward.

  - **param**: `size` { _number_ }

    number of bytes to rewind

- #### <a href="./src/index.coffee?source#L122" target="_blank"><b>read (size)  <small>(alias: unshift, dequeue)</small> </b></a>
    Read bytes from the head of the buffer.

  - **param**: `size` { _number_ }

    number of bytes to read

  - **return**:  { _Buffer_ }

    data

- #### <a href="./src/index.coffee?source#L146" target="_blank"><b>write (value, encoding = "utf8")  <small>(alias: push, enqueue)</small> </b></a>
    see [FlexBuffer](https://github.com/dracupid/flex-buffer#writevalue-encoding--utf8)

  - **param**: `value` { _number | string | Array | Buffer_ }

    The value to write

  - **param**: `encoding` { _string="utf8"_ }

    string encoding

- #### <a href="./src/index.coffee?source#L154" target="_blank"><b>length </b></a>
    length of the data

  - **type**:  { _number_ }



__All the [native Buffer API](https://iojs.org/api/buffer.html) is wrapped. However, read* methods can only read data from head, with no `offset` argument.__

## Test
```
npm test
```

## Benchmark
```
npm run benchmark
```
Environment: OS X 10.10.4, Intel(R) Core(TM) i7-4870HQ CPU @ 2.50GHz

**io.js v2.4.0**
- Read
    - Buffer x 721,399 ops/sec ±0.52% (93 runs sampled)
    - FlexBuffer x 656,232 ops/sec ±0.87% (90 runs sampled)

- wrapped native API
    - Buffer x 17,708,521 ops/sec ±0.72% (93 runs sampled)
    - FlexBuffer x 12,937,044 ops/sec ±0.70% (91 runs sampled)

**io.js v3.0.0**
> see https://github.com/dracupid/flex-buffer#benchmark for more info

- Read
    - Buffer x 323,664 ops/sec ±0.68% (91 runs sampled)
    - FlexBuffer x 320,600 ops/sec ±0.75% (93 runs sampled)

- wrapped native API
    - Buffer x 9,614,392 ops/sec ±0.70% (92 runs sampled)
    - FlexBuffer x 7,115,334 ops/sec ±0.68% (93 runs sampled)

## License
MIT@Jingchen Zhao
