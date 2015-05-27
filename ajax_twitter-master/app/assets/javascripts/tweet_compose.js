
$.TweetCompose = function(el) {
  this.$el = $(el);
  this.$el.submit(this.submit.bind(this));
  this.feedId = this.$el.data("tweets-ul");
  this.$ul = $(this.feedId);
  this.$el.on("keypress", "textarea", this.charsLeft.bind(this));
  this.$el.on("click", "a.add-mentioned-user", this.addMentionedUser.bind(this));
};

$.TweetCompose.prototype.addMentionedUser = function(event) {
  var $scriptTag = $(this.$el.find("script"));
  $(".mentioned-users").append($scriptTag.html());
};

$.TweetCompose.prototype.submit = function(event) {
  event.preventDefault();
  formData = $(event.currentTarget).serialize();
  this.$el.find(":input").attr("disabled", "disabled");
  $.ajax({
    url: "/tweets",
    data: formData,
    type: "POST",
    dataType: "json",
    success: this.handleSucess.bind(this)
  });
};

$.TweetCompose.prototype.handleSucess = function (response) {
  this.clearInput();
  var uglyResponse = JSON.stringify(response);
  var $li = $("<li>").append(uglyResponse);
  console.log($li);
  this.$ul.prepend($li);
  // console.log(response)
  // console.log(JSON.stringify(response))

};

$.TweetCompose.prototype.clearInput = function () {
  var input = this.$el.find(":input");
  // console.log(input);
  this.$el.find("textarea").val('');
  input.removeAttr("disabled");
  $(".chars-left").text("140");
};


$.TweetCompose.prototype.charsLeft =function (event) {
  var $strong = $(".chars-left");
  var charsPut = $(event.currentTarget).val().length;
  var charsLeft = 140 - charsPut;
  $strong.text(charsLeft);
};

$.fn.tweetCompose = function() {
  this.each(function() {
    new $.TweetCompose(this);
    }
  );
};

$(function () {
  $(".tweet-compose").tweetCompose();
});
