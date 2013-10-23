require 'spec_helper'

describe Job do 
  it { should belong_to :user }
  it { should belong_to :team }
  it { should validate_presence_of :name }
  it { should validate_presence_of :team_id }
  it { should have_many :tasks }


  let(:volunteer) { FactoryGirl.create(:volunteer) }
  # let(:event) { FactoryGirl.create(:event) }
  let(:team) { FactoryGirl.create(:team) }

  it "can tell you if the job has been taken by a volunteer" do 
    job = FactoryGirl.create(:job, :team_id => team.id, :user_id => volunteer.id)
    job.owned_by?(volunteer).should eq true
  end

  it "can tell you whether it has been taken" do
    job = FactoryGirl.create(:job, :team_id => team.id, :user_id => volunteer.id)
    job.taken?.should eq true
  end

  it "should return all the complete tasks for a job" do
    job = FactoryGirl.create(:job, :team_id => team.id)
    task1 = FactoryGirl.create(:task, :job_id => job.id)
    task2 = FactoryGirl.create(:task, :job_id => job.id, :done => true) 
    job.completed_tasks.should eq [task2]
  end

  it "should return all incomplete tasks for a job" do
    job = FactoryGirl.create(:job, :team_id => team.id)
    task1 = FactoryGirl.create(:task, :job_id => job.id)
    task2 = FactoryGirl.create(:task, :job_id => job.id, :done => true) 
    job.incompleted_tasks.should eq [task1]
  end

  it "should default to not team leader" do
    job = FactoryGirl.create(:job)
    job.team_leader.should eq false
  end
end
