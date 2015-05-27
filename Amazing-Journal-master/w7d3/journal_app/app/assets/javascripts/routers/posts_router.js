JournalApp.Routers.PostsRouter = Backbone.Router.extend({
  routes: {
    "" : "index",
    "posts/new" : "newPost",
    "posts/:id" : "show",
    "rhoen" : "rhoen"
  },
  initialize: function () {
    this.$content = $(".content");
    this.$sidebar = $('.sidebar');
  },

  rhoen: function () {
    alert('HI');
  },

  newPost: function () {
    if (!this.posts) {
      this.index({callback: this.newPost.bind(this)});
    } else {
      var post = new JournalApp.Models.Post();
      var formView = new JournalApp.Views.PostForm({model: post, collection: this.posts});
      this.$content.html(formView.render().$el);
    }
  },

  index: function (options) {
    this.posts = new JournalApp.Collections.Posts();
    $(".sidebar").empty();
    this.posts.fetch({
      success: function() {
        var postsIndexView = new JournalApp.Views.PostsIndex({collection: this.posts});
        this.$sidebar.append(postsIndexView.render().$el);
      }.bind(this)
    });
    options && options.callback();
  },

  show: function (id) {
    if (!this.posts) {
      this.index({callback: this.show.bind(this, id)});
    } else {
      this.posts.getOrFetch(id, function(post) {
        var postShow = new JournalApp.Views.PostShow({model: post});
        this.$content.html(postShow.render().$el);
      }.bind(this));
    }

  }
});
