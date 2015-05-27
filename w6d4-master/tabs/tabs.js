$.Tabs = function (el) {
  this.$ul = $(el);
  this.$activeLink = this.$ul.find(".active")

  var tabId = this.$ul.data("content-tabs");
  // Does it really have to search the whole
  // document? (Yes.)
  //if you have id, don't use
  //anything else
  this.$contentTabs = $(tabId);

  // get active tab
  this.$activeTab = this.$contentTabs.find(".active");

  this.$ul.on("click", "a", this.clickTab.bind(this));
};

$.Tabs.prototype.clickTab = function (event) {
  this.$activeTab
    .removeClass("active")
    .addClass("transitioning");

  this.$activeLink.removeClass("active");

  this.$activeLink = $(event.currentTarget).addClass("active");

  var id = this.$activeLink.attr("href");

  this.$activeTab.one("transitionend", function(event) {
    this.$activeTab.removeClass("transitioning");

    this.$activeTab = this.$contentTabs.find(id);
    this.$activeTab.addClass('active transitioning');

    setTimeout(function() {
      this.$activeTab.removeClass("transitioning");
    }.bind(this), 0); //really ugly HACK :(

  }.bind(this))
};

$.fn.tabs = function () {
  return this.each(function() {
    new $.Tabs(this);
  });
};
