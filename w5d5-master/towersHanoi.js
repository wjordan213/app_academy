var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame() {
  this.stacks = [[1, 2, 3],[],[]];
};

HanoiGame.prototype.isWon = function () {
  if (this.stacks[1].length === 3 || this.stacks[2].length === 3) {
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
  if (this.stacks[startTowerIdx].length === 0) {
    console.log("Starting stack is empty")
    return false;
  } else if (this.stacks[endTowerIdx].length === 0) {
    return true;
  } else {
    var startDisc = this.stacks[startTowerIdx][0];
    var endDisc = this.stacks[endTowerIdx][0];

    if (startDisc < endDisc) {
      return true;
    } else {
      console.log("Starting disc is greater than ending disc")
      return false;
    }
  }
};

HanoiGame.prototype.move = function (startTowerIdx, endTowerIdx) {
  if ( this.isValidMove(startTowerIdx, endTowerIdx) ) {
    var startTower = this.stacks[startTowerIdx];
    var endTower = this.stacks[endTowerIdx];

    endTower.unshift(startTower.shift());
  }
};

HanoiGame.prototype.print = function() {
  var printFunction = function(stack) {
    console.log(JSON.stringify(stack));
  };
  this.stacks.forEach(printFunction);
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  var that = this

  reader.question("where do you want to move from? ", function (fromTower) {
    reader.question("where do you want to move to? ", function (toTower) {
      fromTower = parseInt(fromTower);
      toTower = parseInt(toTower);

      if (isNaN(fromTower) || isNaN(toTower)) {
        console.log("invalid input");
      }

      if (fromTower < 3 && fromTower >= 0 && toTower < 3 && toTower >= 0) {
        that.move(fromTower, toTower);
      } else{
        console.log('not a tower')
      }

      that.run(callback);
    });
  });

};

HanoiGame.prototype.run = function (completionCallback) {
  if (this.isWon()) {
    console.log('Congrats');
    completionCallback();
  } else {
    this.promptMove(completionCallback);
  }
}



var hanoi = new HanoiGame();
// hanoi.print()
hanoi.run( function() {
  reader.close();
})
