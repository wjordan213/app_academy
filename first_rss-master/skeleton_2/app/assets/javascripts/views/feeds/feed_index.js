NewsReader.Views.FeedIndex = Backbone.CompositeView.extend({
  template: JST["feeds/index"],

  events: {
    "click .delete": "deleteFeed"
  },

  initialize: function () {
    this.listenTo(this.collection, 'sync add remove', this.render);
  },

  render: function () {
    var content = this.template({feeds: this.collection});
    this.$el.html(content);
    return this;
  },

  deleteFeed: function (event) {
    event.preventDefault();
    var id = $(event.currentTarget).data('id');
    var feed = this.collection.getAndFetch(id);
    this.collection.remove(feed);
    feed.destroy();
  }
});
