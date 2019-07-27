# utility functions
require! './signal': {Signal}
require! './helpers': {debug-log, sleep}

debug-log "started application..."
my-signal = new Signal 

do # application greenlet (consumer)
    <- :lo(op) ->
        err, res <- my-signal.wait 1000ms 
        debug-log "#{if err => "TIMEOUT OCCURRED! " else ""}my data: ", res
        lo(op)

do # producer
    i = 0
    <- :lo(op) ->
        my-signal.go err=null, "hello #{i++}"
        <- sleep 2000ms
        lo(op)

/* Example output: 

[ 2019-7-28 2:3:29.53 ] started application...
[ 2019-7-28 2:3:29.74 ] my data:  hello 0
[ 2019-7-28 2:3:30.77 ] TIMEOUT OCCURRED! my data:  undefined
[ 2019-7-28 2:3:31.70 ] my data:  hello 1
[ 2019-7-28 2:3:32.71 ] TIMEOUT OCCURRED! my data:  undefined
[ 2019-7-28 2:3:33.71 ] my data:  hello 2
[ 2019-7-28 2:3:33.72 ] TIMEOUT OCCURRED! my data:  undefined
[ 2019-7-28 2:3:34.73 ] TIMEOUT OCCURRED! my data:  undefined
[ 2019-7-28 2:3:35.72 ] my data:  hello 3
[ 2019-7-28 2:3:36.78 ] TIMEOUT OCCURRED! my data:  undefined
[ 2019-7-28 2:3:37.73 ] my data:  hello 4

*/