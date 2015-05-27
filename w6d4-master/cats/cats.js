;(function () {
  var Carousel = $.Carousel = function(el) {
    this.transitioning = false;
    this.$el = $(el);
    this.activeIdx = 0;
    this.$el.find(":first-child").addClass("active");
    this.$el.find(".slide-left").on("click", function() {
      this.slideLeft();
    }.bind(this));

    this.$pictures = this.$el.find(".items > li");
    this.$el.find(".slide-right").on("click", function() {
      this.slideRight();
    }.bind(this));
  }

  Carousel.prototype.slideLeft = function(){
    if (this.transitioning) return;
    this.slide(-1);
    this.$pictures.eq(this.activeIdx).addClass("left");
    setTimeout(function(){
      this.$pictures.eq(this.activeIdx).removeClass("left")
    }.bind(this), 0);
  };

  Carousel.prototype.slideRight = function(){
    if (this.transitioning) return;
    this.slide(1);
    this.$pictures.eq(this.activeIdx).addClass("right");
    setTimeout(function(){
      this.$pictures.eq(this.activeIdx).removeClass("right")
    }.bind(this), 0);
  };


  Carousel.prototype.slide = function(dir) {
    if (this.transitioning) {
      return;
    }
    console.log("here");
    this.transitioning = true;
    var length = this.$pictures.length;
    var side = dir === 1 ? "left" : "right";
    var $element = this.$pictures.eq(this.activeIdx)
    var that = this;
    $element.addClass(side);
    $element.one("transitionend", function() {
      this.removeClass("active");
      this.removeClass(side);
      that.transitioning = false;
    }.bind($element));

    if (this.activeIdx === 0 && dir === -1) {
      dir = length - 1;
    } else if (this.activeIdx === length - 1 && dir === 1) {
      dir = -1 * (length - 1);
    }
    this.activeIdx += dir;
    this.$pictures.eq(this.activeIdx).addClass("active");

  };



  $.fn.carousel = function(){
    this.each(function() {
      new Carousel(this);
    })
  };
})();
