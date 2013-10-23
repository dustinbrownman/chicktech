class AddTeamIdAndLeaderToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :team_id, :integer
    add_column :jobs, :team_leader, :boolean, :default => false
    remove_column :jobs, :event_id, :integer
  end
end
