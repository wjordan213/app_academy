(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Asteroid = Asteroids.Asteroid = function(game, position) {
    var radius = Asteroid.RADIUS;
    var color = Asteroid.COLOR;
    var velocity = Asteroids.Util.randomVec(5);
    Asteroids.MovingObject.call(this, position, velocity, radius, color, game);
  };

  Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);

  Asteroid.RADIUS = 20;

  Asteroid.COLOR = "green";

  Asteroid.prototype.collideWith = function(otherObject) {
    if (otherObject instanceof Asteroids.Ship) {
      otherObject.relocate();
    }
  };

})();
