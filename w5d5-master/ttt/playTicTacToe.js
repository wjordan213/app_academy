var Components = require("./index")
var readline = require("readline");

var reader = readline.createInterface ({
  input: process.stdin,
  output: process.stdout
});

var completionCallback = function () {
  reader.close();
};

(function() {
  game = new Components.Game(reader);
  game.run(completionCallback);
})()

// instantiate reader
// instantiate TTT.game
// run game
