# **Drink** is a simple, and easy to use Terminal Helper.
# It helps you keep sessions alive, process input, send
# output, and more in a quirky or direct sytnax.
#
# The [source for Drink](http://github.com/nijikokun/drink) is available
# on Github, free of charge under the MIT License or AOL License.
#
# To install Drink make sure you have [Node](http://nodejs.org) and optionally
# [CoffeeScript](http://coffeescript.org) installed. Then, with NPM:
#
#     sudo npm install -g drink
#
# Now you can require Drink in your projects whether they be simple CLI or
# fully fledged IRC clients. Yes, that's where drinks beautiful nature comes in.
# It's very diverse in it's use-case.

# String Utilities, required for parsing input data.
String::strip = -> if String::trim? then @trim() else @replace /^\s+|\s+$/g, ""
String::lstrip = -> @replace /^\s+/g, ""
String::rstrip = -> @replace /\s+$/g, ""

# This drink is exported, a fine export.
module.exports = (process, options = {}) ->
  @process    =  process

  if not @process
    throw new Error "Invalid Process Given"

  # Options and Settings
  # Setup defaults and allow some user-input
  @debug      = options.debug ? false
  @amount     = 1
  @pourRate   = options.rate ? 1000
  @pourFor    = options.for ? 0
  @pouring    = null
  @tap        = []
  @fill       = []
  @tapOn      = true
  @dropper    = null

  # Starts a Stir Process. Stirring handles input, and exiting requests.
  @stir = @start = =>
    @pouring = setInterval () =>
      if @pourRate and @pourRate instanceof Number
        do @spill if @pourRate == @amount

      @log "Poured " + @amount + " cup" + (if @amount == 1 then "." else "s.") if @debug == 2

      @amount++
    , @pourRate

    @process.stdin.resume()

    @process.on 'exit', =>
      @clean

    @process.on 'SIGKILL', =>
      do @dropper if (@dropper)

    @process.stdin.on 'data', (chunk) =>
      @tapOn = true
      data = chunk.toString().trim()
      if (chunk or data) and @fill.length > 0
        for map in @fill
          if map.data and map.data.length
            if map.data == data
              map.callback.apply(this)
          else
            map.callback.apply(this, [ chunk, data ])

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

  # Spills out our current Drink, killing the current process.
  @spill = @exit = =>
    @process.exit()

  # Called whenever the process exits.
  # Prevents Drink from pouring anything else.
  @clean = @clear = =>
    clearInterval @pouring

  # Print out data without ending newline, just a sip of information.
  @sip = @print = (data) =>
    @process.stdout.write data

  # Print out data with an ending newline, a gulp of information.
  @gulp = @printnl = (data) =>
    @process.stdout.write data + '\n'

  # Simple data logger, used for testing or debugging
  # drink really, you can utilize console.log instead
  # in production cases.
  @log = (data) =>
    console.log data

  # Called when SIGKILL is given to process, usually this is called
  # when the user presses CTRL+C
  @onDrop = @onExit = (callback) =>
    @dropper = callback

  # Called when a user inputs more than a single key, also activates
  # onTap which can be cancelled by utilizing:
  #
  #     @tapOn = false
  #
  # which cancels the tap process from firing off.
  #
  #     this.tapOn = false; // Javascript
  @onFill = @onData = (data, callback = (->)) =>
    @fill.push data: data, callback: callback

  # Called when a single key is input or an entire line, which gets broken up into keys.
  # Check the comment block above for more information on how to cancel this.
  @onTap = @onKey = (key, callback = (->)) =>
    @tap.push key: key, callback: callback

  return @