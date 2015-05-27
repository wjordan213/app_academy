window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function($rootEl) {
    new NewsReader.Routers.FeedsRouter($rootEl);
    Backbone.history.start();
  }
};
