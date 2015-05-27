NewsReader.Views.FeedShow = Backbone.CompositeView.extend({
  template: JST["feeds/show"],

  events: {
    "click .refresh": "refresh"
  },

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.entries(), "add", this.addEntryView);
    this.model.entries().each(this.addEntryView.bind(this));
  },

  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  refresh: function () {
    this.model.fetch();
  },

  addEntryView: function (entry) {
    var subview = new NewsReader.Views.ListItem({ model: entry });
    this.addSubview('.entries', subview);
  }
});
