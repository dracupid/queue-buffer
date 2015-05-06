kit = require 'nokit'

kit.glob './memory/*'
.then (fnames) ->
    kit.Promise.all fnames.map (n) ->
        kit.exec "coffee #{n}"
.then (arr) ->
    arr.forEach ({stdout})->
        console.log stdout
.catch (e) ->
    console.error e.stack or e
