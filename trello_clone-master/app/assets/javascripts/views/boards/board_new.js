TrelloClone.Views.BoardNew = Backbone.View.extend({
  initialize: function() {
    this.board = new TrelloClone.Models.Board();
  },

  events: {
    "submit form" : "createNewBoard"
  },

  render: function() {
    var content = JST['boards/new']({board: this.board});
    this.$el.html(content);
    return this;
  },

  createNewBoard: function(event) {
    event.preventDefault();

    var formData = $(event.currentTarget).serializeJSON();
    this.board.set(formData);
    this.board.save({}, {
      success: function() {
        TrelloClone.boards.add(this.board);
        Backbone.history.navigate('boards/' + this.board.id, {trigger: true});
      }.bind(this),

      failure: this.render
    })
  }
});
