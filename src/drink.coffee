###

Drink Coffee

- nijiko `at` goodybag.com
- 2012
- AOL or MIT, You Choose. It's Free.

###

# Utilities
String::strip = -> if String::trim? then @trim() else @replace /^\s+|\s+$/g, ""
String::lstrip = -> @replace /^\s+/g, ""
String::rstrip = -> @replace /\s+$/g, ""

# Our Drink
module.exports = (process, options = []) ->
  @process    =  process

  if not @process
    throw new Error "Invalid Process Given"

  @debug      = options.debug ? false
  @amount     = 1
  @pourRate   = options.pourRate ? 1000
  @pourFor    = options.pourFor ? 0
  @pouring    = null
  @tap        = []
  @fill       = []
  @tapOn      = true

  @stir = @start = =>
    @pouring = setInterval () =>
      if @pourRate and @pourRate instanceof Number
        if @pourRate == @amount
          @spill()

      if @debug == 2
        @log "Poured " + @amount + " cup" + (if @amount == 1 then "." else "s.")

      @amount++
    , @pourRate

    @process.stdin.resume()

    @process.on 'exit', =>
      @clean

    @process.stdin.on 'data', (chunk) =>
      data = chunk.toString().trim()
      if (chunk or data) and @fill.length > 0
        for map in @fill
          if map.data and map.data.length
            if map.data == data
              map.callback.apply(this)
          else
            map.callback.apply(this, [ chunk ])

    @process.stdin.on 'keypress', (chunk, key) =>
      if key && @tap.length > 0 && @tapOn
        for map in @tap
          if map.key and map.key.length and map.key == key.name
            map.callback.apply(this)
          else if map.key and map.key.ctrl and map.key.meta and map.key.shift
            if map.key.ctrl != (key.ctrl || false)
              continue
            if map.key.meta != (key.meta || false)
              continue
            if map.key.shift != (key.shift || false)
              continue
            if map.key.name == key.name
              map.callback.apply(this)

  @spill = @exit = =>
    @process.exit()

  @clean = @clear = =>
    clearInterval @pouring

  @sip = @print = (data) =>
    @process.stdout.write data

  @gulp = @printnl = (data) =>
    @process.stdout.write data + '\n'

  @log = (data) =>
    console.log data

  @onFill = @onData = (data, callback = (->)) =>
    @fill.push data: data, callback: callback

  @onTap = @onKey = (key, callback = (->)) =>
    @tap.push key: key, callback: callback

  return @