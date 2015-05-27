var Board = require("./board");

function Game(reader) {
  this.reader = reader;
  this.currentPlayer = "o";
  this.board = new Board();
}

var upDiag = function() {
  var dag = [];
  for (var i = 0; i < this.board.length; i++) {
    dag.push(this.board[i][i]);
  }
  return dag;
}

var downDiag = function() {
  var dag = [];
  for (var i = 0; i < board.length; i++) {
    dag.push(board[2 - i][i]);
  }
  return dag;
};

var verticals = function() {
  var ups = [[], [], []];
  for (var i = 0; i < this.board.length; i++) {
    for (var j = 0; j < this.board.length; j++) {
      ups[i].push(this.board[i][j]);
    }
  }
  return ups;
};

var horizantles = function() {
  var downs = [[], [], []];
  for (var i = 0; i < this.board.length; i++) {
    for (var j = 0; j < this.board.length; j++) {
      downs[i].push(this.board[j][i]);
    }
  }
  return downs;
};

Game.prototype.won = function () {
  that = this;
  board = this.board;
  combos = [verticals.call(this), horizantles.call(this), [upDiag.call(this)], [downDiag.call(this)]];
  var result = combos.some(function(el, combos) {
    return el.every(function(item, el) {
      return ((item[0] === item[1] && item[1] === item[2]) && item[0] !== undefined);
    });
  });
  return result;
}

Game.prototype.validMove = function () {


}

Game.prototype.makeMove = function (coordinates) {
  var x = coordinates[0];
  var y = coordinates[1];

  this.board.setValue(coordinates, this.currentPlayer);
}

Game.prototype.promptMove = function (callback) {
  this.board.print();
  var that = this;
  var returnInt = function(element) {
    return parseInt(element, 10);
  }
  this.reader.question(this.currentPlayer + "'s turn. Enter coordinates: ", function (coordinates) {
    coordinates = coordinates.split(", ").map(returnInt);
    that.makeMove(coordinates);
    that.run(callback);
  });
}

Game.prototype.run = function (completionCallback) {

  if (this.won()) {
    console.log("Congrats");
    completionCallback();
    return;
  } else {

    if (this.currentPlayer === "o") {
      this.currentPlayer = "x"
    } else {
      this.currentPlayer = "o"
    }

    this.promptMove(completionCallback);
  }
};

module.exports = Game;
