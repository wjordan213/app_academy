class AnswerChoice < ActiveRecord::Base
  validates :body, presence: true
  validates :question_id, presence: true

  belongs_to :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id

  has_one :poll, through: :question, source: :poll
  has_one :author, through: :question, source: :author

  has_many :responses,
    class_name: "Response",
    foreign_key: :answer_choice_id,
    primary_key: :id

  has_many :respondents, through: :responses, source: :user



end
