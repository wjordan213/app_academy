class User < ActiveRecord::Base
  # username attribute, uniqueness and presence validated
  validates :name, presence: true, uniqueness: true

  has_many(
  :polls,
  class_name: "Poll",
  foreign_key: :author_id,
  primary_key: :id
  )

  has_many :questions, through: :polls, source: :questions

  has_many :responses,
  class_name: "Response",
  foreign_key: :user_id,
  primary_key: :id


  has_many :chosen_answers, through: :responses, source: :answer_choice

  def completed_polls
    # returns the polls where the user has answered all of the questions
    completed_polls = User.find_by_sql([<<-SQL, self.id])

      SELECT
        polls.*, COUNT(user_responses.answer_choice_id), COUNT(DISTINCT questions.id)
      FROM
        polls
      JOIN
        questions ON questions.poll_id = polls.id
      JOIN
        answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN
        (
          SELECT
            *
          FROM
            responses
          JOIN
            users ON responses.user_id = users.id
          WHERE
            users.id = 2

          ) AS user_responses ON user_responses.answer_choice_id = answer_choices.id
      GROUP BY
        polls.id
      HAVING
        COUNT(user_responses.answer_choice_id) = COUNT(DISTINCT questions.id)

    SQL

    completed_polls
  end

  #   LEFT OUTER JOIN
  #     users ON responses.user_id = users.id

  def uncompleted_polls
    # returns the polls where the user has answered all of the questions
    uncompleted_polls = User.find_by_sql([<<-SQL, self.id])
      SELECT
        polls.*
      FROM
        polls
      JOIN
        questions ON questions.poll_id = polls.id
      JOIN
        answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN
        responses ON responses.answer_choice_id = answer_choices.id
      JOIN
        users ON responses.user_id = users.id
      WHERE
        users.id = ?
      GROUP BY
        polls.id
      HAVING
        COUNT(responses.answer_choice_id) < COUNT(questions.id)

    SQL

    uncompleted_polls
  end


  def sub
    User.find_by_sql([<<-SQL, self.id])
      SELECT
        *
      FROM
        responses
      WHERE
        responses.user_id = ?
    SQL
  end
end

# (
#   SELECT
#     *
#   FROM
#     responses
#   WHERE
#     responses.user_id = ?) responses ON responses.answer_choice_id = answer_choices.id
