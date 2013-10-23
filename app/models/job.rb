class Job < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  belongs_to :team
  has_many :tasks
  validates_presence_of :name
  validates_presence_of :team_id

  def owned_by?(user)
    self.user_id == user.id
  end

  def completed_tasks
    tasks.complete
  end

  def incompleted_tasks
    tasks.incomplete
  end

  def taken?
    self.user_id != nil
  end
end
