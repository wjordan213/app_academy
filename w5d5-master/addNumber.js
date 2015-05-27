var readline = require('readline');

var reader = readline.createInterface ({
  input: process.stdin,
  output: process.stdout
});



var addNumbers = function (sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("please choose a number: ", function (num_string) {
      sum += parseInt(num_string);
      numsLeft -= 1;
      console.log(sum);

      addNumbers(sum, numsLeft, completionCallback);
    });
  } else {
    completionCallback(sum);
    reader.close();
  }
};

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});
