TrelloClone.Views.NewList = Backbone.View.extend({

  initialize: function(board) {
    this.list = new TrelloClone.Models.List();
    this.board_id = board.id;
  },

  events: {
    "submit .newList" : "createList"
  },

  render: function() {
    var content = JST['lists/new']({list: this.list, board_id: this.board_id});
    this.$el.html(content);
    return this;
  },

  createList: function(event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON();
    this.list.set(formData);
    this.list.save({}, {
      success: function() {
        board.lists().add(this.list);
        Backbone.history.navigate('#boards/' + this.list.get('board_id'), {trigger: true});
      }.bind(this)
    })
  }
})
