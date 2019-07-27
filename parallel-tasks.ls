# A multi-thread-like, sequential code example
require! './helpers': {debug-log, sleep}

do
    i = 3
    debug-log "start"
    # first loop 
    <~ :lo(op) ~>
        debug-log "hi #{i}"
        i := i - 1
        if i is 0
            return op! # break
        <~ sleep 1000ms
        lo(op)
    <~ sleep 1500ms
    # second loop 
    <~ :lo(op) ~>
        debug-log "hello #{i}"
        i := i + 1
        if i is 3
            return op! # break
        <~ sleep 1000ms
        lo(op)
    debug-log "heyy"

do
    a = 5
    <~ :lo(op) ~>
        debug-log "this runs in parallel!", a
        a := a - 1
        if a is 0
            return op! # break
        <~ sleep 500ms
        lo(op)

/* Output:

[ 2019-7-28 2:6:27.885 ] start
[ 2019-7-28 2:6:27.901 ] hi 3
[ 2019-7-28 2:6:27.902 ] this runs in parallel! 5
[ 2019-7-28 2:6:28.404 ] this runs in parallel! 4
[ 2019-7-28 2:6:28.903 ] hi 2
[ 2019-7-28 2:6:28.904 ] this runs in parallel! 3
[ 2019-7-28 2:6:29.404 ] this runs in parallel! 2
[ 2019-7-28 2:6:29.904 ] hi 1
[ 2019-7-28 2:6:29.904 ] this runs in parallel! 1
[ 2019-7-28 2:6:31.406 ] hello 0
[ 2019-7-28 2:6:32.407 ] hello 1
[ 2019-7-28 2:6:33.409 ] hello 2
[ 2019-7-28 2:6:33.410 ] heyy

*/
