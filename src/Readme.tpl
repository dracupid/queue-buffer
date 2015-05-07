Queue-Buffer
===================
A flex buffer which behaves as a dynamic queue with a complete but limited Buffer API.
- Queue-Buffer extends [Flex-Buffer](https://github.com/dracupid/flex-buffer).
- Tested on Node 0.8-0.12, latest iojs on Mac, Linux and Windows.
- Entities in the queue are kept in order and the only operations on the collection are the addition of entities to the rear terminal position, known as enqueue(write), and removal of entities from the front terminal position, known as dequeue(read).

[![NPM version](https://badge.fury.io/js/queue-buffer.svg)](https://www.npmjs.com/package/queue-buffer)
[![Deps](https://david-dm.org/dracupid/queue-buffer.svg?style=flat)](https://david-dm.org/dracupid/queue-buffer)
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
Environment: io.js v2.0.0, OS X 10.10.2, Intel(R) Core(TM) i7-4870HQ CPU @ 2.50GHz

- Read
    - Buffer x 710,928 ops/sec ±0.40% (91 runs sampled)
    - FlexBuffer x 687,658 ops/sec ±1.44% (90 runs sampled)

- wrapped native API
    - Buffer x 20,815,938 ops/sec ±0.59% (94 runs sampled)
    - FlexBuffer x 14,698,706 ops/sec ±0.84% (93 runs sampled)

## License
MIT@Dracupid
