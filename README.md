# Livescript Examples 

signal.ls: 

* `<- wait-for \my-signal`: pause execution at this point, till someone lets `go \my-signal`
* `<- go \my-signal`: let go some code who `wait-for \my-signal`
* `reason <- timeout-wait-for 3000ms, \my-signal`: pause execution similar to `wait-for \my-signal` at most `3000ms`

## Helper functions: 

* `<- sleep, 3000ms`: pause execution for `3000ms`
* `debug-log "my example output"`: like `console.log`, but prepends timestamp till execution 
