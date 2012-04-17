# Drink.coffee

Drink Coffee. or Java*Script*. Daily.

# 

### Overview

Small, beautiful, elegant, and easy to use Terminal Keep-Alive Module.

No. Seriously. It also has humour or not for those serious types. Javascript and Coffeescript supported, examples shown are in coffee-script.

### Installation

The easiest way to install Drink is to utilize **npm**

`npm install drink`

Then inside your script, require drink.

`drink = require 'drink'`

### Usage

Utilizing Drink is very simple. For a basic keep alive all you need is this:

``` coffee
Coffee = drink process
Coffee.stir()
```

And it will keep terminal open.

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

Aliased Method: `onKey`

Let's say you just want to get information, in general?

```
Coffee.onFill(null, (data) ->
  this.gulp "You said: " + data
)
```