# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

h = User.create!(name:'Harris')
j = User.create!(name: 'Jeremy')

h_poll = h.polls.create!(title: 'Thanks obama?')
j_poll = j.polls.create!(title: 'Shakespeare or Cervantes?')

h_question = h_poll.questions.create!(question: 'Thanks Obama?')
question2 = h_poll.questions.create!(question: 'Really though?')

j_choice = j_poll.questions.create!(question: 'Regicide?')
j_poll.questions.create!(question: 'Chivalry?')

h_question.answer_choices.create!(body: "He's lame")
h_question.answer_choices.create!(body: "He's pretty cool I guess")
j_choose = h_question.answer_choices.create!(body: "He's Jesus")


j_choose2 = question2.answer_choices.create!(body: "Maybe?")


j_choice.answer_choices.create!(body: "We’ll have thee, as our rarer monsters are, Painted on a pole, and underwrit, 'Here may you see the tyrant.'")


j.responses.create!(answer_choice_id: j_choose.id)
j.responses.create!(answer_choice_id: j_choose2.id)

h.responses.create!(answer_choice_id: AnswerChoice.first.id)
