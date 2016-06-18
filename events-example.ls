# A multi-thread-like, sequential code example
# with signalling

# for debugging purposes
st = new Date! .get-time!
debug-log = (...print) ->
    console.log (new Date! .get-time! - st) + "ms :" + print.join(' ')

# utility functions
require! {
    "./signal": {wait-for, go, sleep}
}

do # greenlet 1
    i = 3
    debug-log "start"
    <- :lo(op) ->
        debug-log "waiting for something #{i}"
        i--
        <- wait-for \something
        if i is 0
            return op! # break
        lo(op)
    <- sleep 1500ms
    <- :lo(op) ->
        debug-log "hello #{i}"
        i++
        if i is 3
            return op! # break
        <- sleep 1000ms
        lo(op)
    <- sleep 0
    debug-log "heyy"

do # greenlet 2
    delay = 3000ms
    debug-log "greenlet-2 will start in #{delay}ms second..."
    <- sleep delay 
    a = 8
    <- :lo(op) ->
        debug-log "let something go (runs in parallel!)", a
        a--
        go \something
        if a is 0
            return op! # break
        <- sleep 1000ms
        lo(op)


/* output:

0ms : start
2ms : hi 3
3ms : this runs in parallel! 8
3ms : hi 2
505ms : this runs in parallel! 7
505ms : hi 1
1007ms : this runs in parallel! 6
1508ms : this runs in parallel! 5
2009ms : this runs in parallel! 4
2509ms : hello 0
2509ms : this runs in parallel! 3
3010ms : this runs in parallel! 2
3509ms : hello 1
3510ms : this runs in parallel! 1
4511ms : hello 2
4511ms : heyy

*/
