function Clock() {
}

Clock.TICK = 5000;

Clock.prototype.printTime = function() {
  var seconds = this.seconds;
  var hours = this.hours;
  var minutes = this.minutes;

  if (seconds < 10) {
    seconds = '0' + seconds;
  }
  if (hours < 10) {
    hours = '0' + hours;
  }
  if (minutes < 10) {
    minutes = '0' + minutes;
  }

  console.log(hours + ":" + minutes + ":" + seconds);
};

Clock.prototype.run = function() {
  this.currentTime = new Date();
  this.hours = this.currentTime.getHours();
  this.minutes = this.currentTime.getMinutes();
  this.seconds = this.currentTime.getSeconds();

  this.printTime();

  // callbacks happen now
  setInterval(this._tick.bind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  this.incrementSeconds();
  this.printTime();
};

Clock.prototype.incrementSeconds  = function(){
  this.seconds += 5;
  if (this.seconds >= 60) {
    this.seconds -= 60;
    this.incrementMinutes();
  }
};

Clock.prototype.incrementMinutes = function() {
  this.minutes += 1;
  if (this.minutes === 60) {
    this.minutes = 0;
    this.incrementHours();
  }
};

Clock.prototype.incrementHours = function() {
  this.hours += 1;
  if (this.hours === 24) {
    this.hours = 0;
  }
}

var clock = new Clock();
clock.run();
