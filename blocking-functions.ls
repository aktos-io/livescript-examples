# Sometimes we need blocking functions.
# simply use signals/events

require! {
    "./signal": {
        wait-for, go, sleep, debug-log
    }
}


debug-log "started application..."

# function definition
my-blocking-function = ->
    debug-log "this function will block for 2 seconds..."
    <- sleep 2000ms
    go \my-blocking-function


# application
my-blocking-function!
<- wait-for \my-blocking-function
debug-log "passed blocking function..."
