# A multi-thread-like, sequential code example 

st = new Date! .get-time!
td = -> (new Date! .get-time! - st) + "ms :"
sleep = (ms, f) !-> set-timeout f, ms 

do
  i = 3
  console.log td!, "start"
  <- :lo(op) ->
    console.log td!, "hi #{i}"
    i := i - 1
    if i is 0
      op!;return
    <- sleep 1000ms
    lo(op)
  <- sleep 1500ms
  <- :lo(op) -> 
    console.log td!, "hello #{i}"
    i := i + 1
    if i is 3
      op!;return
    <- sleep 1000ms
    lo(op)
  console.log td!, "heyy"

do 
  a = 5
  <- :lo(op) -> 
    console.log td!, "this runs in parallel!", a
    a := a - 1 
    if a is 0
      op!;return 
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
