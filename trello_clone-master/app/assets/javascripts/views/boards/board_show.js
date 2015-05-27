TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  initialize: function() {
    this.$el.addClass('clearfix')
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.lists(), 'add', this.addListView.bind(this));
  },

  template: function() {
    return JST['boards/show']({board: this.model});
  },

  addListView: function(list) {
    if (!list.get('title')) { return }
    var subview = new TrelloClone.Views.ShowItem({model: list, board: this.model});
    this.addSubview('.lists', subview);
  },

  render: function() {
    var content = this.template();
    console.log(this.subviews());
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});
