Pokedex.Router = Backbone.Router.extend({
  routes: {
    '' : 'pokemonIndex',
    'pokemon/:id': 'pokemonDetail',
    'pokemon/:pokemonId/toys/:toyId': 'toyDetail'
  },


  pokemonDetail: function (id, callback) {
    if (!this._pokemonIndex){
      this.pokemonIndex(this.pokemonDetail.bind(this, id, callback));
    } else{
      this._pokemonDetail = this._pokemonIndex.pokes.get(id);
      var pokemon = this._pokemonIndex.pokes.get(id);
      var pokemonDetailView = new Pokedex.Views.PokemonDetail( {model: pokemon});

      $("#pokedex .pokemon-detail").html(pokemonDetailView.$el);
      pokemonDetailView.refreshPokemon({model: pokemon, success: callback});
    }
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon({success: callback});
    this.pokemonForm();
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
  },

  toyDetail: function (pokemonId, toyId) {
    if (!this._pokemonDetail) {
      this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId));
    } else {
      var toy = this._pokemonDetail.toys().get(toyId);
      var toyView = new Pokedex.Views.ToyDetail({model: toy});
      $("#pokedex .toy-detail").html(toyView.$el);
      toyView.render();
    }

  },

  pokemonForm: function () {
    var pokeForm = new Pokedex.Views.PokemonForm({model: new Pokedex.Models.Pokemon, collection: this._pokemonIndex.pokes});
    pokeForm.render();
    $('#pokedex .pokemon-form').html(pokeForm.$el);
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
