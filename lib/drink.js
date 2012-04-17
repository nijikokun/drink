
/*

Drink Coffee

- nijiko `at` goodybag.com
- 2012
- AOL or MIT, You Choose. It's Free.
*/

(function() {

  String.prototype.strip = function() {
    if (String.prototype.trim != null) {
      return this.trim();
    } else {
      return this.replace(/^\s+|\s+$/g, "");
    }
  };

  String.prototype.lstrip = function() {
    return this.replace(/^\s+/g, "");
  };

  String.prototype.rstrip = function() {
    return this.replace(/\s+$/g, "");
  };

  module.exports = function(process, options) {
    var _ref, _ref2, _ref3,
      _this = this;
    if (options == null) options = [];
    this.process = process;
    if (!this.process) throw new Error("Invalid Process Given");
    this.debug = (_ref = options.debug) != null ? _ref : false;
    this.amount = 1;
    this.pourRate = (_ref2 = options.pourRate) != null ? _ref2 : 1000;
    this.pourFor = (_ref3 = options.pourFor) != null ? _ref3 : 0;
    this.pouring = null;
    this.tap = [];
    this.fill = [];
    this.tapOn = true;
    this.stir = this.start = function() {
      _this.pouring = setInterval(function() {
        if (_this.pourRate && _this.pourRate instanceof Number) {
          if (_this.pourRate === _this.amount) _this.spill();
        }
        if (_this.debug === 2) {
          _this.log("Poured " + _this.amount + " cup" + (_this.amount === 1 ? "." : "s."));
        }
        return _this.amount++;
      }, _this.pourRate);
      _this.process.stdin.resume();
      _this.process.on('exit', function() {
        return _this.clean;
      });
      _this.process.stdin.on('data', function(chunk) {
        var data, map, _i, _len, _ref4, _results;
        data = chunk.toString().trim();
        if ((chunk || data) && _this.fill.length > 0) {
          _ref4 = _this.fill;
          _results = [];
          for (_i = 0, _len = _ref4.length; _i < _len; _i++) {
            map = _ref4[_i];
            if (map.data && map.data.length) {
              if (map.data === data) {
                _results.push(map.callback.apply(_this));
              } else {
                _results.push(void 0);
              }
            } else {
              _results.push(map.callback.apply(_this, [chunk]));
            }
          }
          return _results;
        }
      });
      return _this.process.stdin.on('keypress', function(chunk, key) {
        var map, _i, _len, _ref4, _results;
        if (key && _this.tap.length > 0 && _this.tapOn) {
          _ref4 = _this.tap;
          _results = [];
          for (_i = 0, _len = _ref4.length; _i < _len; _i++) {
            map = _ref4[_i];
            if (map.key && map.key.length && map.key === key.name) {
              _results.push(map.callback.apply(_this));
            } else if (map.key && map.key.ctrl && map.key.meta && map.key.shift) {
              if (map.key.ctrl !== (key.ctrl || false)) continue;
              if (map.key.meta !== (key.meta || false)) continue;
              if (map.key.shift !== (key.shift || false)) continue;
              if (map.key.name === key.name) {
                _results.push(map.callback.apply(_this));
              } else {
                _results.push(void 0);
              }
            } else {
              _results.push(void 0);
            }
          }
          return _results;
        }
      });
    };
    this.spill = this.exit = function() {
      return _this.process.exit();
    };
    this.clean = this.clear = function() {
      return clearInterval(_this.pouring);
    };
    this.sip = this.print = function(data) {
      return _this.process.stdout.write(data);
    };
    this.gulp = this.printnl = function(data) {
      return _this.process.stdout.write(data + '\n');
    };
    this.log = function(data) {
      return console.log(data);
    };
    this.onFill = this.onData = function(data, callback) {
      if (callback == null) callback = (function() {});
      return _this.fill.push({
        data: data,
        callback: callback
      });
    };
    this.onTap = this.onKey = function(key, callback) {
      if (callback == null) callback = (function() {});
      return _this.tap.push({
        key: key,
        callback: callback
      });
    };
    return this;
  };

}).call(this);
