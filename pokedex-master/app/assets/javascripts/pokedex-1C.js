Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var pokemon = new Pokedex.Models.Pokemon(attrs);

  pokemon.save({}, {
    success: function(model, response, options) {
      this.pokes.add(pokemon);
      this.addPokemonToList(pokemon);
      callback(pokemon);
    }.bind(this)
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var formData = $(event.currentTarget).serializeJSON().pokemon;
  this.createPokemon(formData, this.renderPokemonDetail.bind(this));
};
