class AddColumnsToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :description, :string
    add_column :pets, :status, :string
  end
end
