JournalApp.Views.PostsIndex = Backbone.View.extend({
  tagName: 'ul',
  initialize: function () {
    this.listenTo(this.collection, "sync remove add", this.render);
  },

  render: function() {
    this.$el.empty();
    this.collection.forEach(function(post) {

      var postView = new JournalApp.Views.ListItem({model: post, collection: this.collection});
      this.$el.append(postView.render().$el);
    }.bind(this));
    this.$el.append('<a href="#/posts/new">New Post!</a>');

    return this;
  }
});
