window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new JournalApp.Routers.PostsRouter();
  }
};

$(document).ready(function(){
  JournalApp.initialize();
  Backbone.history.start();
});
