TrelloClone.Views.CardItem = Backbone.View.extend({
  template: JST['cards/card_item'],

  tagName: 'li',

  render: function() {
    var content = this.template({card: this.model});
    this.$el.html(content);

    return this;
  }
})
