TrelloClone.Views.ListItem = Backbone.View.extend ({

  render: function() {
    var content = JST['boards/list_item']({board: this.model});
    this.$el.html(content);
    return this;
  }
});
