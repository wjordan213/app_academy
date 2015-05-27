NewsReader.Collections.Feeds = Backbone.Collection.extend({
  model: NewsReader.Models.Feed,
  url: '/api/feeds',

  getAndFetch: function(id) {
    var feed = this.get(id);

    if (feed) {
      feed.fetch();
    } else {
      feed = new NewsReader.Models.Feed();
      feed.set({ id: id });
      feed.fetch({
        success: function () {
          this.add(feed);
        }.bind(this)
      });
    }

    return feed;
  }
});
