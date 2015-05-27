json.array! list.cards do |card|
  json.partial! 'card', card: card
end
