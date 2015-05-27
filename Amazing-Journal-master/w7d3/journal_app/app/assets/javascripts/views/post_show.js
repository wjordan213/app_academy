JournalApp.Views.PostShow = Backbone.View.extend({
  template: JST['posts/show'],

  events: {
    "click button" : "deletePost",
    "click a" : "navigate"
  },

  navigate: function (event) {
    event.preventDefault();
    Backbone.history.navigate($(event.currentTarget).attr("href"), {trigger: true});
  },

  render: function() {
    this.$el.html(this.template({post: this.model}));
    return this;
  },

  deletePost: function () {
    this.model.destroy({
      success: function() {
        this.collection.remove(this.model);
      }.bind(this)
    });
  }

});
