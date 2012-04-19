# Drink.coffee

Drink Coffee, or JavaScript. Daily.

#

### Overview

**Drink** is a simple, and easy to use Terminal Helper. It helps you keep sessions alive, process input, send output, and more in a quirky or direct sytnax.

No. Seriously. It has humour or not for those serious types. Both Javascript and Coffeescript are supported, examples shown below are in coffee-script.

### Installation

The easiest way to install Drink is to utilize **npm**

`npm install drink`

Then inside your script, require drink.

`drink = require 'drink'`

### Use Cases

What can drink be used for? Simple. A lot. Everything from CLI to IRC Clients to Zebra Tracking Utilities. Seriously.
Drink allows you to simply keep alive a terminal session. Think about that. You can make a Twitter Client, Reddit Poster, quite literally anything.

Now you see it's power.

### Usage

Utilizing Drink is very simple. For a basic keep alive all you need is this:

``` coffee
Coffee = drink process
do Coffee.stir
```

This will initialize drink with the current terminal process allowing it to keep your session alive and accept input information.
More often than naught you might want it to process for a certain amount of times or at a specific rate, Drink supports this:

``` coffee
# Default Option Settings
# rate - the amount of time in-between pours, in milliseconds.
# for - the amount of pours you want drink to process.
# debug - numerical / boolean, 2 is to show pour amounts.
Coffee = drink process, rate: 1000, for: 0, debug: false

# Begin Stirring
do Coffee.stir
```

#### Stirring

In Drink, keeping the Session alive in terminal is considered `stirring`, just as with the basic usage.

``` coffee
Coffee = drink process
Coffee.stir()
```

For those who think they may not remember this, or are confused as to what it does, you can also use it's aliased function `start`

``` coffee
Coffee = drink process
Coffee.start()
```

#### Spilling

To stop the session from stirring you simply `spill` the session or cup out.

``` coffee
Coffee = drink process

# Initialize the session
Coffee.stir()

# Kill or Exit the session.
Coffee.spill()
```

Once again, this also has an alias called `exit`

### Terminal Output Methods

#### Sipping

Are you one of those who don't like fully gulping down a cup? Well just sip on it. *Spec Note: This may change*

Sipping allows you to push to console or terminal without appending newlines.

``` coffee
Coffee = drink process
Coffee.stir()

Coffee.sip("Hello ")
Coffee.sip("World!")
```

Aliased Method: `print`

#### Gulping

Maybe you do prefer to gulp down some information; We certainly can help provide that functionality. *Spec Note: This may change*

Same as sip, with a newline appended.

``` coffee
Coffee = drink process
Coffee.stir()

Coffee.gulp("Hello")
Coffee.gulp("World!")
```

Aliased Method: `printnl`

### Terminal Input Methods

### Single Character Input

Useful for those Y/N Questions a lot of people seem to bring up in conversation. For those quick little bursts of information we simply use an `onTap` method with a nice callback.

``` coffee
Coffee = drink process
Coffee.stir()

Coffee.onTap(';', ->
  # We want to exit now. They used a semi-colon, my weakness!
  # We also bind this, so you can easily manipulate the parent.
  this.spill()
)
```

Aliased Method: `onKey`

There is a little more functionality, such as meta-keys:

```
Coffee.onTap({ name: 'd', ctrl: true }, ->
  this.gulp "Hello World!"
)
```

Supports `ctrl`, `meta`, `shift`

### Data Input

For those who need a mouthfull of information we simply use an `onFill` method with a nice callback.

``` coffee
Coffee = drink process
Coffee.stir()

Coffee.onFill('exit;', ->
  # We want to exit now. They typed exit!
  # We also bind this, so you can easily manipulate the parent.
  this.spill()
)
```

Aliased Method: `onData`

Let's say you just want to get information, in general?
The first argument passed is a binary output from the process, do with this as you wish.
The second argument passed is a string output that has been **pre-trimmed* by drink. Enjoy~

```
Coffee.onFill(null, (chunk, data) ->
  this.gulp "You said: " + data
)
```