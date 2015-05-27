var Cat = function(name, owner) {
  this.name = name;
  this.owner = owner;

};

Cat.prototype.cuteStatement = function() {
    return this.owner + " loves " + this.name;
};

var sennacy = new Cat('sennacy', 'jonny');
var frenchy = new Cat('Frenchy', 'Harris');
var cat = new Cat('Cat', 'Liann');

console.log(frenchy.cuteStatement());

Cat.prototype.cuteStatement = function() {
  return "Everyone loves " + this.name;
};

console.log(frenchy.cuteStatement());

 Cat.prototype.meow = function() {
   return "meow meow";
 };

 console.log(sennacy.meow());

 frenchy.__proto__.meow = function() {
   return "merp merp";
 };

 console.log(frenchy.meow());
 console.log(cat.meow());
