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



- #### <a href="./src/index.coffee?source#L12" target="_blank"><b>QueueBuffer.AUTO\_RELEASE_THRESHOLD</b></a>
  Auto release threshold(ms)

  - **<u>type</u>**: { _number_ }

- #### <a href="./src/index.coffee?source#L21" target="_blank"><b>constructor(arg, opts = {})</b></a>
  see [FlexBuffer](https://github.com/dracupid/flex-buffer#constructorarg-opts--)

  - **<u>param</u>**: `arg` { _number | Buffer | Array | string_ }

    The same arg as Buffer.

  - **<u>param</u>**: `opts` { _Object={}_ }

    options

  - **<u>option</u>**: `autoRelease` { _boolean_ }

    auto       release useless space

  - **<u>option</u>**: `autoReleaseThreshold` { _number_ }

    auto release threshold(ms)

- #### <a href="./src/index.coffee?source#L33" target="_blank"><b>free()</b></a>
  Release useless space which has been read.

- #### <a href="./src/index.coffee?source#L80" target="_blank"><b>move(size)</b></a>
  Move current read offset.

  - **<u>param</u>**: `size` { _number_ }

    number of bytes to move, can be negative.

- #### <a href="./src/index.coffee?source#L90" target="_blank"><b>skip(size)</b></a>
  Move current read offset forward.

  - **<u>param</u>**: `size` { _number_ }

    number of bytes to skip

- #### <a href="./src/index.coffee?source#L100" target="_blank"><b>rewind(size)</b></a>
  Move current read offset backward.

  - **<u>param</u>**: `size` { _number_ }

    number of bytes to rewind

- #### <a href="./src/index.coffee?source#L122" target="_blank"><b>read(size) (alias: unshift, dequeue) </b></a>
  Read bytes from the head of the buffer.

  - **<u>param</u>**: `size` { _number_ }

    number of bytes to read

  - **<u>return</u>**: { _Buffer_ }

    data

- #### <a href="./src/index.coffee?source#L146" target="_blank"><b>write(value, encoding = "utf8") (alias: push, enqueue) </b></a>
  see [FlexBuffer](https://github.com/dracupid/flex-buffer#writevalue-encoding--utf8)

  - **<u>param</u>**: `value` { _number | string | Array | Buffer_ }

    The value to write

  - **<u>param</u>**: `encoding` { _string="utf8"_ }

    string encoding

- #### <a href="./src/index.coffee?source#L154" target="_blank"><b>length</b></a>
  length of the data

  - **<u>type</u>**: { _number_ }



__All the [native Buffer API](https://iojs.org/api/buffer.html) is wrapped. However, read* methods can only read data from head, with no `offset` argument.__

## Test
```
npm test
```

## Benchmark
```
npm run benchmark
```
Environment: io.js v2.0.0, OS X 10.10.2, Intel(R) Core(TM) i7-4870HQ CPU @ 2.50GHz

- Read
    - Buffer x 710,928 ops/sec ±0.40% (91 runs sampled)
    - FlexBuffer x 687,658 ops/sec ±1.44% (90 runs sampled)

- wrapped native API
    - Buffer x 20,815,938 ops/sec ±0.59% (94 runs sampled)
    - FlexBuffer x 14,698,706 ops/sec ±0.84% (93 runs sampled)

## License
MIT@Jingchen Zhao
