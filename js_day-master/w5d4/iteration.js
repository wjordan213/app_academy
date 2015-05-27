var bubbleSort = function(arr) {
  var sorted = false;
  while (!sorted) {
    sorted = true;

    for (var i = 0; i < arr.length - 1; i++) {
      if (arr[i] > arr[i + 1]) {
        sorted = false;
        var temp = arr[i+1];
        arr[i+1] = arr[i];
        arr[i] = temp;
      };
    };
  };
};

var substrings = function(str) {
  var result = [];
  for(var i = 0; i < str.length; i++) {
    for(var j = i + 1; j < str.length + 1; j++) {
      sub = str.substring(i, j);
      if(result.indexOf(sub) === -1) {
        result.push(sub);
      };
    };
  };
  return result;
};
