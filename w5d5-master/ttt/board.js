function Board() {
  // grid rep of board
  this.board = [[null, null, null],[null, null, null],[null, null, null]];
};

Board.prototype.print = function () {
  var printRow = function(row) {
    console.log(JSON.stringify(row));
  };
  this.board.forEach(printRow);
};

Board.prototype.setValue = function(coords, value) {
  this.board[coords[0]][coords[1]] = value;
}

module.exports = Board;
