(function () {
  if (typeof Asteroids === "undefined"){
    window.Asteroids = {};
  }

  var Game = Asteroids.Game = function (xDim, yDim){
    this.asteroids = [];
    this.xDim = xDim;
    this.yDim = yDim;
    this.addAsteroids();
    this.ship = new Asteroids.Ship(this.randomPosition(), this);

  };


  Game.NUM_ASTEROIDS = 5;

  var allObjects = Game.prototype.allObjects = function () {
    return this.asteroids.concat([this.ship]);
  };

  var checkCollisions = Game.prototype.checkCollisions = function () {
    var objects = this.allObjects();
    for (var i = 0; i < objects.length - 1; i++) {
      var item = objects[i];
      var roids = objects.slice(i + 1);
      for (var j = 0; j < roids.length; j++) {
        if (item.isCollidedWith(roids[j])) {
          item.collideWith(roids[j]);
        }
      }
    }
  };

  var step = Game.prototype.step = function(ctx) {
    this.moveObjects();
    this.checkCollisions();
    this.draw(ctx);
  };

  Game.prototype.addAsteroids = function() {
    for (var i = 0; i < Game.NUM_ASTEROIDS; i++) {
      this.asteroids.push(new Asteroids.Asteroid(this, this.randomPosition()));
    }
  };

  var randomPosition = Game.prototype.randomPosition = function () {
    var x = Math.random() * this.xDim;
    var y = Math.random() * this.yDim;
    return [x, y];
  };

  var remove = Game.prototype.remove = function (asteroid) {
    this.asteroids = this.asteroids.slice(0, this.asteroids.indexOf(asteroid)).concat(this.asteroids.slice(this.asteroids.indexOf(asteroid) + 1, this.asteroids.length));
  };


  var draw = Game.prototype.draw = function(ctx) {
    var objects = this.allObjects();
    ctx.clearRect(0,0, this.xDim, this.yDim);
    var that = this;

    for (var i = 0; i < objects.length; i++) {
      objects[i].draw(ctx);
    }

  };

  var moveObjects = Game.prototype.moveObjects = function(ctx) {
    var objects = this.allObjects();
    objects.forEach(function(el) {
      el.move(ctx);
    });
  };


  Game.prototype.wrap = function(pos) {
    var x = pos[0];
    var y = pos[1];
    if (x < 0) {
      x = x + this.xDim;
    }else if (x > this.xDim) {
      x = x - this.xDim;
    }

    if (y < 0) {
      y = y + this.yDim;
    }else if (y > this.yDim) {
      y = y - this.yDim;
    }

    return [x, y];
  };


})();
