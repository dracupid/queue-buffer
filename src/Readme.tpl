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
