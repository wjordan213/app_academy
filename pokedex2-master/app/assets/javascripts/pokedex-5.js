Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click .poke-list-item": "selectPokemonFromList"
  },

  initialize: function () {
    this.pokes = new Pokedex.Collections.Pokemon();
    this.listenTo (this.pokes, "sync add", this.render);
    this.$pokeList = this.$el.find('.pokemon-list');
  },

  addPokemonToList: function (pokemon) {
    var content = JST["pokemonListItem"]({pokemon: pokemon})
    this.$el.append(content);
  },

  refreshPokemon: function (options) {
    this.pokes.fetch({
      success: function(){
        if (options.success){options.success()}
        this.render()
      }.bind(this)
    });
  },

  render: function () {
    this.$el.empty();
    this.pokes.forEach(function(pokemon){
      this.addPokemonToList(pokemon);
    }.bind(this));
  },

  selectPokemonFromList: function (event) {
    var $item = $(event.currentTarget);
    var id = $item.data('id');
    var route = Backbone.history.navigate("pokemon/" + id, {trigger: true});
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li": "selectToyFromList"
  },

  refreshPokemon: function (options) {
    options.model.fetch({
      success: function(response) {
        if (options.success){options.success()}
        this.render();
     }.bind(this)
    });
  },

  render: function () {
    var content = JST['pokemonDetail']({pokemon: this.model});
    this.$el.html(content);
    this.model.toys().forEach(function(toy){
      var content = JST["toyListItem"]({toy: toy})
      this.$el.find(".toys").append(content)
    }.bind(this));
  },

  selectToyFromList: function (event) {
    var $item = $(event.currentTarget);
    var pokemonId = $item.data('pokemon-id');
    var id = $item.data('id');
    // var toy = this.model.toys().get(id);
    // var toyView = new Pokedex.Views.ToyDetail({model: toy});
    // $("#pokedex .toy-detail").html(toyView.$el);
    // toyView.render();

    Backbone.history.navigate("pokemon/" + pokemonId + "/toys/" + id, {trigger: true});
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({

  render: function () {
    var content = JST['toyDetail']({pokes: [], toy: this.model});
    this.$el.html(content);
  }
});

//
// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
