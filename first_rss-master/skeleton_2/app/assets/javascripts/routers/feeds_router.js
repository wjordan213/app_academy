NewsReader.Routers.FeedsRouter = Backbone.Router.extend({
  routes: {
    "": "feedIndex",
    "feeds/:id": "feedShow"
  },

  initialize: function($rootEl) {
    this._feeds = new NewsReader.Collections.Feeds();
    this._feeds.fetch();
    this.$rootEl = $rootEl;
  },

  feedIndex: function() {
    var feedIndex = new NewsReader.Views.FeedIndex({collection: this._feeds});
    this._swapView(feedIndex);
  },

  feedShow: function (id) {
    var feed = this._feeds.getAndFetch(id);
    var feedShow = new NewsReader.Views.FeedShow({model: feed});
    this._swapView(feedShow);
  },

  _swapView: function(view) {
    if (this._currentView) {
      this._currentView.remove();
    }
    this._currentView = view;
    this.$rootEl.html(this._currentView.render().$el);
  }
});
