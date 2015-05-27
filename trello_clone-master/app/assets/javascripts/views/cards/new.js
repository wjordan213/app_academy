TrelloClone.Views.NewCard = Backbone.View.extend({
  template: JST['cards/form'],

  events: {
    "submit form" : "addCard"
  },

  initialize: function(options) {
    this._card = new TrelloClone.Models.Card();
    this._listId = options.listId;
    this._collection = options.collection;
    TrelloClone.collection = this._collection;
  },


  render: function() {
    console.log(this._listId)
    var content = this.template({card: this._card, list_id: this._listId})
    this.$el.html(content);
    return this;
  },

  addCard(event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON();
    var card = new TrelloClone.Models.Card();
    card.set(formData);
    console.log(card);
    card.save({}, {
      success: function() {
        debugger;
        TrelloClone.collection.add(card);
      }
    })
  }
})
