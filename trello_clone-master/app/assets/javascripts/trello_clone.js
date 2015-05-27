window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function($rootEl) {
    new TrelloClone.Routers.Router($rootEl);
  }
};
