TrelloClone.Collections.Boards = Backbone.Collection.extend({
  url: '/api/boards',
  model: TrelloClone.Models.Board,

  getAndFetch: function(id) {
    var board = this.get(id);

    if (board) {
      board.fetch();
    } else {
      board = new TrelloClone.Models.Board();
      board.set({id: id});
      board.fetch();
      this.add(board);
    }
    return board;
  }
});

TrelloClone.boards = new TrelloClone.Collections.Boards();
