JournalApp.Views.ListItem = Backbone.View.extend({
  tagName: 'li',
  template: JST['posts/listItem'],
  events: {
    "click button" : "deletePost"
  },
  render: function (){
    this.$el.append(this.template({post: this.model}));
    return this;
  },

  deletePost: function () {
    this.model.destroy({
      success: function() {
        this.collection.remove(this.model);
      }.bind(this)
    });
  }

});
