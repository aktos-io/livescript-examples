# A multi-thread-like, sequential code example

require! {
    "./signal": {
        sleep, debug-log
    }
}

do
  i = 3
  debug-log "start"
  <- :lo(op) ->
    debug-log "hi #{i}"
    i := i - 1
    if i is 0
      return op! # break
    <- sleep 1000ms
    lo(op)
  <- sleep 1500ms
  <- :lo(op) ->
    debug-log "hello #{i}"
    i := i + 1
    if i is 3
      return op! # break
    <- sleep 1000ms
    lo(op)
  debug-log "heyy"

do
  a = 5
  <- :lo(op) ->
    debug-log "this runs in parallel!", a
    a := a - 1
    if a is 0
      return op! # break
    <- sleep 500ms
    lo(op)


/* Output:
    0ms : start
    2ms : hi 3
    4ms : this runs in parallel! 5
    506ms : this runs in parallel! 4
    1004ms : hi 2
    1009ms : this runs in parallel! 3
    1512ms : this runs in parallel! 2
    2007ms : hi 1
    2015ms : this runs in parallel! 1
    3510ms : hello 0
    4514ms : hello 1
    5517ms : hello 2
    5520ms : heyy
*/
