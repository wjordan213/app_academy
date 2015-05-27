window.Pokedex = (window.Pokedex || {});
window.Pokedex.Models = {};
window.Pokedex.Collections = {};

Pokedex.Models.Pokemon = Backbone.Model.extend({

  urlRoot: '/pokemon',

  toys: function() {
    if (typeof this._toys === "undefined") {
      this._toys = new Pokedex.Collections.PokemonToys();
    }
    return this._toys;
  },

  parse: function (jsonResp) {
    if (jsonResp.toys) {
      this.toys().set(jsonResp.toys);
      delete jsonResp.toys;
    }
    return jsonResp;
  }

});

Pokedex.Models.Toy = Backbone.Model.extend({

});

Pokedex.Collections.Pokemon = Backbone.Collection.extend({

  url: '/pokemon',
  model: Pokedex.Models.Pokemon
});

Pokedex.Collections.PokemonToys = Backbone.Collection.extend({
  model: Pokedex.Models.Toy
});

window.Pokedex.Test = {
  testShow: function (id) {
    var pokemon = new Pokedex.Models.Pokemon({ id: id });
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  },

  testIndex: function () {
    var pokemon = new Pokedex.Collections.Pokemon();
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  }
};

window.Pokedex.RootView = function ($el) {
  this.$el = $el;
  this.pokes = new Pokedex.Collections.Pokemon();
  this.$pokeList = this.$el.find('.pokemon-list');
  this.$pokeDetail = this.$el.find('.pokemon-detail');
  this.$newPoke = this.$el.find('.new-pokemon');
  this.$toyDetail = this.$el.find('.toy-detail');

  this.$pokeList.on('click', 'li',                                                this.selectPokemonFromList.bind(this));

  console.log(this.$el.find('.pokemon-detail .toys'));

  this.$el.on('click', '.toys li',          this.selectToyFromList.bind(this));

  this.$el.find('.new-pokemon')
  .on('submit', this.submitPokemonForm.bind(this));

};


$(function() {
  var $rootEl = $('#pokedex');
	window.Pokedex.rootView = new Pokedex.RootView($rootEl);
  window.Pokedex.rootView.refreshPokemon();
});
