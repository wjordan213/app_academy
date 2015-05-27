TrelloClone.Views.IndexView = Backbone.CompositeView.extend({
  initialize: function() {
    this.listenTo(TrelloClone.boards, 'sync', this.render);
    this.listenTo(TrelloClone.boards, 'add', this.addItemView);
    this.listenTo(TrelloClone.boards, 'remove', this.removeIndexView);

    TrelloClone.boards.each(this.addItemView.bind(this));
    TrelloClone.boards.fetch();
  },

  events: {
    "click .delete" : "destroy"
  },

  addItemView: function(board) {
    var subview = new TrelloClone.Views.ListItem({ model: board });
    this.addSubview('.boards', subview);
  },

  template: function() {
    return JST['boards/index'];
  },

  render: function() {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  removeIndexView: function(board) {
    this.removeModelSubview('.boards', board)
  },

  destroy: function(event) {
    event.preventDefault;
    var id = $(event.currentTarget).data('id');
    var board = this.collection.getAndFetch(id);
    this.removeIndexView(board);
    // debugger;
    board.destroy();
  }

});
