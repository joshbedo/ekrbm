class AddPriorityToFoos < ActiveRecord::Migration
  def change
    add_column :foos, :priority, :integer, default: 0
  end
end
