Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $detail = $('<ul>');
  $detail.addClass('detail');
  var $img = $('<img src="'+ pokemon.escape('image_url') +'">');
  $detail.append($img);

  for (var attr in pokemon.attributes) {
    if (attr == "image_url"){
      continue;
    }
    $detail.append(attr + ': ' + pokemon.escape(attr) + '<br>');
  }

  $detail.append('<br>');

  $('<ul>')
    .addClass('toys')
    .append('Toys: <br><br>')
    .appendTo($detail);

  var that = this;

  pokemon.fetch({
    success: function() {
      pokemon.toys().forEach( that.addToyToList.bind(that) )
    }
  });

  this.$pokeDetail.html($detail);
};



Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.currentTarget).data('id');
  var pokemon = this.pokes.get(id);
  this.renderPokemonDetail(pokemon);
};
