# utility functions
require! {
    "./signal": {timeout-wait-for, go, sleep, debug-log}
}

do # application greenlet
    debug-log "started application..."
    <- :lo(op) ->
        reason <- timeout-wait-for 2000ms, \my-signal
        debug-log "my data: ", reason
        lo(op)


do # receiver
    <- :lo(op) ->
        <- sleep 1000ms
        debug-log "SIMULATING data received!"
        go \my-signal
        lo(op)
