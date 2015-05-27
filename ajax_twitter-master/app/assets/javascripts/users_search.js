$.UsersSearch = function ($el) {
  this.$el = $el;
  this.$input = $(this.$el.find("input") );
  this.$ul = $( this.$el.find("ul") );
  this.$input.keypress(this.handleInput.bind(this));
};

$.UsersSearch.prototype.handleInput = function(event) {
  console.log(event);
  var val = this.$input.serialize();
  console.log(val);
  $.ajax ({
    url: "/users/search",
    type: "GET",
    data: val,
    dataType: "json",
    success: this.renderResults.bind(this)
  });
}

$.UsersSearch.prototype.renderResults = function(response) {
  this.$ul.empty();
  var that = this;
  response.forEach(function(object){
    that.$ul.append(that.makeListItem(object));
  });
};

var makeFollowToggle = function(followState, userId) {
  var button = $("<button class='follow-toggle'>")
                .attr("type", "submit")
                .followToggle({followState: followState, userId: userId})
  return button;
}

$.UsersSearch.prototype.makeListItem = function (object) {
  var userId = object.id;
  var username = object.username;
  var link =  "" + userId;
  var followState = (object.followed) ? "followed" : "unfollowed";
  var $li = $("<li>");

  $li.append($('<a>')
  .attr('href', link)
  .text(username))
  .append(makeFollowToggle(followState, userId));

  return $li;

}


$.fn.usersSearch = function () {
  this.each(function(){
    new $.UsersSearch($(this));
  })
};

$(function () {
  $(".users-search").usersSearch();
});
