Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  $('<li>')
    .data('id', pokemon.id)
    .append(pokemon.escape('name') + ': ')
    .append(pokemon.escape('poke_type'))
    .addClass('poke-list-item')
    .appendTo(this.$pokeList);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  var that = this;
  this.pokes.fetch({

    success: function () {
      that.pokes.forEach( that.addPokemonToList.bind(that) );
    }

  });
};
