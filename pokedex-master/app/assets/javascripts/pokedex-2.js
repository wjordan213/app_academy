Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $ul = this.$el.find('.toys');

  $("<li>")
    .data('toy-id', toy.id)
    .data('pokemon-id', toy.escape('pokemon_id'))
    .append("name: " + toy.escape('name') + '<br>')
    .append("happiness: " + toy.escape('happiness')  + '<br>')
    .append("price: " + toy.escape('price')  + '<br><br>')
    .appendTo($ul);
};



Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var $toyImg = $('<img src="' + toy.escape('image_url') + '">');

  this.$toyDetail.html($toyImg);
};






Pokedex.RootView.prototype.selectToyFromList = function (event) {

  var pokemon = this.pokes.get($(event.currentTarget).data('pokemon-id'));
  var toy = pokemon.toys().get($(event.currentTarget).data('toy-id'));
  this.renderToyDetail(toy);


};
