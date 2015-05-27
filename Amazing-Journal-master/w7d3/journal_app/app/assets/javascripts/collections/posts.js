JournalApp.Collections.Posts = Backbone.Collection.extend ({
  model: JournalApp.Models.Post,
  url: "/posts",

  getOrFetch: function(id, callback) {
    var post = this.get(id);
    if (post) {
      post.fetch({
        success: callback(post)
      });
    } else {
      post = new JournalApp.Models.Post({id: id});
      post.fetch({
        success: function () {
          callback(post);
          this.add(post);
        }.bind(this)
      });
    }
  },


});
