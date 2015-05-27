TrelloClone.Models.List = Backbone.Model.extend({
  urlRoot: "/api/lists",

  parse: function(response) {
    this.cards().set(response.cards);
    delete response.cards;
    return response;
  },

  cards: function() {
    this._cards =  this._cards || new TrelloClone.Collections.Cards({list: this});
    return this._cards;
  }
})
