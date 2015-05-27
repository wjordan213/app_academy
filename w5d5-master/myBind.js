Function.prototype.myBind = function (context) {
  var fn = this;

  return function () {
    fn.apply(context);
  };
};

var cat = {
  name: 'garfield',
  sayHi: function () {
    console.log(this.name + " says hi");
  }
};

var dog = {
  name: 'dante'
};

cat.sayHi();

var hiMethod = cat.sayHi;

hiMethod.bind(dog)()
hiMethod.myBind(dog)();
