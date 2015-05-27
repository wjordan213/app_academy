
Array.prototype.myUniq2 = function() {
  var uniqs = [];
  for (var i = 0; i < this.length; i++) {
    if (uniqs.indexOf(this[i]) === -1) {
      uniqs.push(this[i]);
    };
  };
  return uniqs;
};


Array.prototype.myUniq = function() {
  var uniqs = [];
  for (var i = 0; i < this.length; i++) {
    if (!uniqs.includes(this[i])) {
      uniqs.push(this[i]);
    };
  };
  return uniqs;
};

Array.prototype.includes = function(num) {
  for (var i = 0; i < this.length; i++) {
    if (this[i] === num) {
      return true;
    };
  };
  return false;
};

var comparer = function(a, b) {
  if (a === -b) {
    return true;
  }
  else {
    return false;
  };
};

Array.prototype.twoSum = function() {
  sums = [];
  for(var i = 0; i < this.length - 1; i++ ) {
    for(var j = i + 1; j < this.length; j++) {
      if(comparer(this[i], this[j])) {
        sums.push([i, j]);
      };
    };
  };
  return sums;
}

Array.prototype.myTranspose = function() {
  var transposed = [];
  for(var i = 0; i < this[0].length; i++) {
    transposed.push([]);
  };

  for(var j = 0; j < transposed.length; j++){
    for(var k = 0; k < this.length; k++) {
      transposed[j][k] = this[k][j];
    };
  };
  return transposed;
};

Array.prototype.myMap = function(func) {
  // uses myEach and a closure\
  console.log(this)
  var arr = [];
  var assigner = function(element) {
    arr.push(func(element));
  };

  this.myEach(assigner);
  return arr;
};

Array.prototype.myEach = function(block) {
  for(i = 0; i < this.length; i++) {
    block(this[i]);
  };
};

Array.prototype.myInject = function(func) {
  var array = this.slice(0);
  var result = array.shift();

  var perIteration = function(element) {
    result = func(element, result);
  };

  array.myEach(perIteration);
  return result;
};

var func = function(el, accum) {
  return accum + el;
};
