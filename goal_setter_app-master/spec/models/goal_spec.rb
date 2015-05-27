require 'rails_helper'

RSpec.describe Goal, :type => :model do
  describe "validations" do
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:user_id)}

    it do
      should validate_inclusion_of(:private_or_public).
      in_array(%w(private public)).
      with_message("must be public or private")
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
  end

end
