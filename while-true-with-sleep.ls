sleep = (ms, f) -> set-timeout f, ms 

do # greenlet 1
    console.log "Loop 1 started!"
    i = 0
    <- :lo(op) ->
        console.log "Loop1: Hello!"
        <- sleep 2000ms
        if i++ > 3
            return op!  # use like "break"
        lo(op)
    console.log "Loop 1 Ended!!"

do # greenlet 2
    console.log "Loop 2 started!"
    i = 0
    <- :lo(op) ->
        console.log "Loop2: world!"
        <- sleep 2000ms
        if i++ > 3
            return op!  # use like "break"
        lo(op)
    console.log "Loop 2 Ended!!"
