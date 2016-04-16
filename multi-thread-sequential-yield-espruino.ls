# A multi-thread-like, sequential code example 

# for debugging purposes 
st = new Date! .get-time!
td = -> (new Date! .get-time! - st) + "ms :"

# utility functions 
sleep = (ms, f) !-> set-timeout f, ms 
wait-for = (virtual-pin, callback) !-> set-watch callback, virtual-pin, {edge: \rising, repeat: yes}
go = (virtual-pin) !-> [digital-write virtual-pin, state for state in [off, on]]

# application
do
  i = 3
  console.log td!, "start"
  <- :lo(op) ->
    console.log td!, "hi #{i}"
    i := i - 1
    <- wait-for 14
    if i is 0
      op!;return # break 
    <- sleep 1000ms
    lo(op)
  <- sleep 1500ms
  <- :lo(op) -> 
    console.log td!, "hello #{i}"
    i := i + 1
    if i is 3
      op!;return # break 
    <- sleep 1000ms
    lo(op)
  console.log td!, "heyy"

do 
  a = 5
  <- :lo(op) -> 
    console.log td!, "this runs in parallel!", a
    a := a - 1 
    go 14
    if a is 0
      op!;return # break 
    <- sleep 500ms
    lo(op)
    
