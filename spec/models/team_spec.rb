require 'spec_helper'

describe Team do
  it { should belong_to :event }
  it { should validate_presence_of :name }
  it { should have_many :jobs }

  describe "leader" do
    it "gives you the user who is team leader" do
      user = FactoryGirl.create(:volunteer)
      team = FactoryGirl.create(:team)
      job = FactoryGirl.create(:job, :team_id => team.id, :user_id => user.id, :team_leader => true)
      team.leader.should eq user
    end

    it "returns nil if there is no one signed up for team leader" do
      user = FactoryGirl.create(:volunteer)
      team = FactoryGirl.create(:team)
      job = FactoryGirl.create(:job, :team_id => team.id)
      team.leader.should eq nil
    end
  end
end 