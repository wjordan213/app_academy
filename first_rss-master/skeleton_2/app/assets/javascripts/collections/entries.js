NewsReader.Collections.Entries = Backbone.Collection.extend({
  model: NewsReader.Models.Entry,

  url: function () {
    return this.feed.url() + '/entries';
  },

  initialize: function (entries, options) {
    this.feed = options.feed;
  }
});
