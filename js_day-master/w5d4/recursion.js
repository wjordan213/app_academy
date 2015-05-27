var range = function(start, end) {
  if (end < start) {
    return [];
  }
  else {
    return [start].concat(range(start + 1, end));
  };
};

var recSum = function(arr) {
  var result = arr.slice();
  if (result.length === 1) {
    return result[0];
  }
  else {
    return result.shift() + recSum(result);
  };
};

var exp = function(b, n) {
  if (n === 0) {
    return 1;
  }
  else {
    return b * exp(b, n-1);
  };
};

var exp2 = function(b, n) {
  if (n === 0) {
    return 1;
  }
  else if (n === 1) {
    return b;
  }
  else if (n % 2 === 0) {
    return exp2(b, n/2) * exp2(b, n/2);
  }
  else {
    return b * exp2(b, (n-1) / 2) * exp2(b, (n-1) / 2);
  };
};

var fib = function(n) {
  var fibs = [0, 1];
  if (n <= 2){
    return fibs.slice(0, n);
  }
  else {
    var result = fib(n-1);
    var new_num = result[result.length - 1] + result[result.length - 2];
    result.push(new_num);
    return result;
  };
};

var bsearch = function(arr, target) {
  if (arr.length === 0 || (arr.length === 1 && arr[0] !== target)) {
    return false;
  };

  var pivot = Math.floor(arr.length / 2);

  if (arr[pivot] > target) {
    return bsearch(arr.slice(0, pivot), target);
  }
  else if (arr[pivot] === target) {
    return pivot;
  }
  else {
    var result = bsearch(arr.slice(pivot, arr.length), target);
    if (result === false) {
      return false;
    }
    else {
      return pivot + result;
    };
  };
};




var makeChange = function(amount, coins) {
  var bestCoins = [];
  if( amount === 0) {
    return [];
  }

  for (var i = 0; i < coins.length; i++) {
    var currentLargest = coins[i];
    if (currentLargest <= amount) {
      var newAmount = amount - currentLargest;
      var bestWithoutLargest = makeChange(newAmount, coins.slice(i, coins.length));
      var coinsArray = [currentLargest].concat(bestWithoutLargest);

      if (bestCoins.length === 0 || coinsArray.length < bestCoins.length) {
        bestCoins = coinsArray;
      }
    }
  }
  return bestCoins;
};
