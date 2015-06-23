;(function() {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Ship = Asteroids.Ship = function (position, game) {
    velocity = [0,0];
    Asteroids.MovingObject.call(this, position, velocity, Ship.RADIUS, Ship.COLOR, game);
  };

  Ship.COLOR = "yellow";
  Ship.RADIUS = 10;

  Asteroids.Util.inherits(Ship, Asteroids.MovingObject);

  Ship.prototype.isShip = function () {
    return true;
  };

  Ship.prototype.relocate = function() {
    var position = this.game.randomPosition();
    this.xCoord = position[0];
    this.yCoord = position[1];
  };

  Ship.prototype.power = function(impulse) {
    console.log('hello world');
    var xImp = impulse[0];
    var yImp = impulse[1];
    this.velocity[0] += xImp;
    this.velocity[1] += yImp;
  };


})();
