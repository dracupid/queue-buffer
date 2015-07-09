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

<%= api %>

__All the [native Buffer API](https://iojs.org/api/buffer.html) is wrapped. However, read* methods can only read data from head, with no `offset` argument.__

## Test
```
npm test
```

## Benchmark
```
npm run benchmark
```
Environment: io.js v2.0.3, OS X 10.10.4, Intel(R) Core(TM) i7-4870HQ CPU @ 2.50GHz

- Read
    - Buffer x 710,196 ops/sec ±0.21% (96 runs sampled)
    - FlexBuffer x 661,346 ops/sec ±0.55% (93 runs sampled)

- wrapped native API
    - Buffer x 18,077,082 ops/sec ±0.80% (93 runs sampled)
    - FlexBuffer x 13,009,392 ops/sec ±0.73% (90 runs sampled)

## License
MIT@Jingchen Zhao
