TrelloClone.Views.ShowItem = Backbone.CompositeView.extend({
  template: JST['lists/showItem'],

  tagName: 'div',

  initialize: function(opts) {
    this.board = opts.board;

    // setup event listener for this.cards
    this.listenTo(this.model.cards(), 'add', this.addCardView.bind(this));
    this.listenTo(this.model.cards(), 'add', this.render.bind(this));

    this.model.cards().each(function(card) {
      // debugger;
      this.addCardView(card);
    }.bind(this))
    // iterate through this.cards
  },

  events: {
    "click .delete" : "deleteItem",
    "click .newCard" : "newCardView"
  },

  addCardView: function(card) {
    var subview = new TrelloClone.Views.CardItem({model: card, list: this.model});
    this.addSubview('.cards', subview);
  },

  render: function() {
    var content = this.template({list: this.model, board: this.board});
    this.$el.html(content);
    this.attachSubviews();
    // debugger;
    return this;
  },

  newCardView: function() {
    console.log(this.model.get('id'));
    var newView = new TrelloClone.Views.NewCard({listId: this.model.id, collection: this.model.cards() });
    console.log('yup')
    this.addSubview('.newCardView', newView);
  },

  deleteItem: function() {
    this.model.destroy();
    this.remove();
  }
});
