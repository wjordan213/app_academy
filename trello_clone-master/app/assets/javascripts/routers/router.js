TrelloClone.Routers.Router = Backbone.Router.extend({
  routes: {
    '': 'index',
    'boards/new': 'newBoard',
    'boards/:id': 'show',
    'lists/new/:boardId' : 'newList'
  },

  initialize: function($rootEl) {
    this.$rootEl = $rootEl;
  },

  index: function() {
    var idxPost = new TrelloClone.Views.IndexView({ collection: TrelloClone.boards });
    idxPost.render();
    this.swapView(idxPost);
  },

  show: function(id) {
    var showPost = new TrelloClone.Views.BoardShow({ model: TrelloClone.boards.getAndFetch(id) });
    this.swapView(showPost);
  },

  newBoard: function() {
    var newPost = new TrelloClone.Views.BoardNew({collection: TrelloClone.boards});
    this.swapView(newPost);
  },

  newList: function(boardId) {
    var board = TrelloClone.boards.getAndFetch(boardId);
    var newList = new TrelloClone.Views.NewList(board);
    this.swapView(newList);
  },

  listShow: function(userId, id) {
    var listShow = new TrelloClone.Views.ListShow({model: list});
    this.swapView(listShow);
  },

  swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(this._currentView.render().$el)
  }

});
