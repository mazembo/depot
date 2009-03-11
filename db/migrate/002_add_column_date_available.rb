class AddColumnDateAvailable < ActiveRecord::Migration
  def self.up
  	add_column:products, :Date_available, :datetime
  end

  def self.down
  	remove_column:products, :Date_available
  end
end
