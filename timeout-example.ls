# utility functions
require! {
    "./signal": {timeout-wait-for, go, sleep, debug-log}
}

do # application greenlet
    debug-log "started application..."
    reason <- timeout-wait-for 2000ms, \my-signal
    debug-log "my data: ", reason


do # receiver
    <- sleep 3000ms
    debug-log "SIMULATING data received!"
    go \my-signal
