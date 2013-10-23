require 'spec_helper'

describe User do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :phone }
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of :role }

  it { should have_many :jobs }
  it { should have_many :events }
  it { should have_many :teams }

  it "tells you each unique event it is signed up for" do
    user = FactoryGirl.create(:volunteer)
    event = FactoryGirl.create(:event)
    team = FactoryGirl.create(:team, :event_id => event.id)
    job1 = FactoryGirl.create(:job, :user_id => user.id, :team_id => team.id)
    job2 = FactoryGirl.create(:job, :user_id => user.id, :team_id => team.id)
    user.unique_events.should eq [event]
  end

  it "tells you each unique team it is signed up for" do
    user = FactoryGirl.create(:volunteer)
    team = FactoryGirl.create(:team)
    job1 = FactoryGirl.create(:job, :user_id => user.id, :team_id => team.id)
    job2 = FactoryGirl.create(:job, :user_id => user.id, :team_id => team.id)
    user.unique_teams.should eq [team]
  end

  it "sends an e-mail" do
    user = FactoryGirl.create(:volunteer)
    user.send_information
    ActionMailer::Base.deliveries.last.to.should eq [user.email]
  end

  describe "role?" do
    it "tells you whether the user has the input role or greater" do
      user = FactoryGirl.create(:admin)
      user.role?(:volunteer).should eq true
    end
  end
end
