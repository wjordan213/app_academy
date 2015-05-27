JournalApp.Views.PostForm = Backbone.View.extend({
  template: JST["posts/form"],

  render: function(options) {
    this.$el.empty();
    options && this.$el.append(options.errors);
    this.$el.append(this.template({post: this.model}));
    return this;
  },

  events: {
    "submit form" : "create"
  },

  create: function(event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON();
    this.model = new JournalApp.Models.Post(formData);
    this.model.save({}, {
      success: function() {
        console.log('success!');
        this.collection.add(this.model, {merge: true});
        Backbone.history.navigate("", {trigger: true});
      }.bind(this),

      failure: function(response) {
        this.render({errors: response.errors});
      }

    });
  }
});
