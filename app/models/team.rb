class Team < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :name
  has_many :jobs

  def leader
    @leader = Job.where(:team_id => self.id, :team_leader => true)
    if @leader.first
      @leader.first.user
    end
  end
end