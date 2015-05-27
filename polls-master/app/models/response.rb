class Response < ActiveRecord::Base
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_author

  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id



  belongs_to :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  has_one :question, through: :answer_choice, source: :question


  def sibling_responses
    self.question.responses.where('responses.id != ? OR ? IS NULL', id, id)
  end


  def author
    self.answer_choice.author
  end


  private

    def respondent_has_not_already_answered_question
      if sibling_responses.exists?(user_id: user_id)
        errors[:user_id] << "Respondent has already answered question"
      end
    end

    def respondent_is_not_author
      if author.id == user_id
        errors[:user_id] << "Poll author cannot answer her own questions"
      end
    end




end
