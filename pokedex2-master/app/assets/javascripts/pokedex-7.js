Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    'submit .new-pokemon' : 'savePokemon'
  },

  render: function () {
    this.$el.html(JST["pokemonForm"]);
  },

  savePokemon: function (event) {
    event.preventDefault();
    var pokeData = $(event.currentTarget).serializeJSON().pokemon;
    var pokemon = new Pokedex.Models.Pokemon();
    pokemon.set(pokeData);
    that = this;
    pokemon.save({}, {
      success: function(model, response, options){
        console.log(this);
        this.collection.add(model);
        Backbone.history.navigate('pokemon/' + model.id, {trigger: true});
      }.bind(that)
    })
  }
});
