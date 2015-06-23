(function() {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var GameView = Asteroids.GameView = function(game, ctx) {
    this.game = game;
    this.ctx = ctx;
  };

  GameView.prototype.bindKeyHandlers = function() {
    that = this;
    key('a', function() { that.game.ship.power([-1, 0]); });
    key('s', function() { that.game.ship.power([0, 1]); });
    key('d', function() { that.game.ship.power([1, 0]); });
    key('w', function() { that.game.ship.power([0, -1]); });
  };

  GameView.prototype.start = function(){
    var that = this;
    this.bindKeyHandlers();
    window.setInterval((function () {
      that.game.step(that.ctx);
    }), 20);

  };

})();
