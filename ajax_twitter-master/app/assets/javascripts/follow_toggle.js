$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id") || options.userId;
  this.followState = this.$el.data("initial-follow-state") || options.followState;
  this.render();
  this.$el.on("click", this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function () {
  var buttonText;
  if (this.followState === "followed") {
    buttonText = "Unfollow!";
    this.$el.removeAttr("disabled");
  }
  else if (this.followState === "unfollowed"){
    buttonText = "Follow!";
    this.$el.removeAttr("disabled");
  }
  else {
    this.$el.attr("disabled", "disabled");
  }



  this.$el.text(buttonText);
};

$.FollowToggle.prototype.handleClick = function(event) {
  event.preventDefault();
  var type, nextState;
  if (this.followState === "unfollowed") {
    type = "POST";
    this.followState = "following";
    nextState = "followed";
  }else{
    type = "DELETE";
    this.followState = "unfollowing";
    nextState = "unfollowed";
  }

  this.render();
  $.ajax({
    url: "/users/" + this.userId + "/follow",
    type: type,
    dataType: 'json',
    success: function (response) {
      this.followState = nextState;
      this.render();
    }.bind(this)
  });
}

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
