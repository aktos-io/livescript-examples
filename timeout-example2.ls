# utility functions
require! {
    "./signal": {timeout-wait-for, go, sleep, debug-log}
}

console.log "Started application..."

do # application greenlet
    debug-log "GREENLET 1: started..."
    <- :lo(op) ->
        debug-log "GREENLET 1: waiting for data..."
        reason <- timeout-wait-for 2000ms, \my-signal
        debug-log "GREENLET 1: my data: ", reason
        lo(op)


do # receiver
    debug-log "GREENLET 2: started..."
    <- :lo(op) ->
        <- sleep 3000ms
        debug-log "GREENLET 2: SIMULATING data received!"
        go \my-signal
        lo(op)
