class Question < ActiveRecord::Base

  validates :poll_id, presence: true
  validates :question, presence: true

  belongs_to :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id

  has_many :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id

  has_many :responses, through: :answer_choices, source: :responses

  has_one :author, through: :poll, source: :author

  def results
    answers = {}

    answer_choices.includes(:responses).each do |choice|
      answers[choice] = choice.responses.length
    end
    answers
  end

  def better_results

    answers = {}
    results = Question.find_by_sql([<<-SQL, self.id])
    SELECT
      answer_choices.*, COUNT(responses.answer_choice_id) AS count
    FROM
      answer_choices
    LEFT OUTER JOIN
      responses ON responses.answer_choice_id = answer_choices.id
    WHERE
      answer_choices.question_id = ?
    GROUP BY
      answer_choices.id

    SQL

    results.each do |result|
      answers[result] = result.count
    end
    answers
  end

  def best_results
    answers = {}

    choices = answer_choices
              .select('answer_choices.*, COUNT(responses.answer_choice_id) AS count')
              .joins('LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id')
              .group('answer_choices.id')

    choices.each do |result|
      answers[result] = result.count
    end

    answers
  end
end
