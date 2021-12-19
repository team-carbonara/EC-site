class ChangeStatusDefaultOnOrder < ActiveRecord::Migration[5.2]
  def up
    change_column :orders, :status,:integer, default: 0
  end

  def down
    change_column :orders, :status,:integer
  end
end
