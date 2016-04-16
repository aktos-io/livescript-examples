# A multi-thread-like, sequential code example
# with signalling

# for debugging purposes
st = new Date! .get-time!
td = -> (new Date! .get-time! - st) + "ms :"

# utility functions
sleep = (ms, f) !-> set-timeout f, ms

wait-events = {}
get-wait-event = (event-id) ->
    ev_ = wait-events[event-id]
    if ev_ is void
        ev_ = {callbacks: [], run: no, waiting: no}
        wait-events[event-id] = ev_
    return ev_

run-waiting-event = (event-id) ->
    ev_ = get-wait-event event-id
    if ev_.waiting and ev_.run
        ev_.run = no
        ev_.waiting = no
        for callback in ev_.callbacks
            callback!

wait-for = (event-id, callback) !->
    ev_ = get-wait-event event-id
    if callback.to-string! not in [..to-string! for ev_.callbacks]
        ev_.callbacks ++= [callback]
        #console.log "not found, adding callback: ", callback
    ev_.waiting = yes
    run-waiting-event event-id

go = (event-id) !->
    ev_ = get-wait-event event-id
    ev_.run = yes
    run-waiting-event event-id

# application
do
    i = 3
    console.log td!, "start"
    <- :lo(op) ->
        console.log td!, "hi #{i}"
        i--
        <- wait-for \something
        if i is 0
            op!;return # break
        lo(op)
    <- sleep 1500ms
    <- :lo(op) ->
        console.log td!, "hello #{i}"
        i++
        if i is 3
            op!;return # break
        <- sleep 1000ms
        lo(op)
    <- sleep 0
    console.log td!, "heyy"

do
    a = 5
    <- :lo(op) ->
        console.log td!, "this runs in parallel!", a
        a--
        go \something
        if a is 0
            op!;return # break
        <- sleep 500ms
        lo(op)


/* output:

0ms : start
2ms : hi 3
3ms : this runs in parallel! 5
4ms : hi 2
505ms : this runs in parallel! 4
505ms : hi 1
1007ms : this runs in parallel! 3
1508ms : this runs in parallel! 2
2009ms : this runs in parallel! 1
2508ms : hello 0
3510ms : hello 1
4510ms : hello 2
4512ms : heyy
*/
