get-formatted-date = -> 
    d = new Date 
    "#{d.getFullYear!}-#{d.getMonth! + 1}-#{d.getDate!} #{d.getHours!}:#{d.getMinutes!}:#{d.getSeconds!}.#{d.getMilliseconds!}"

export debug-log = -> 
    console.log ...['[', getFormattedDate(), ']', ...arguments]

export sleep = (ms, f) -> 
    set-timeout f, ms