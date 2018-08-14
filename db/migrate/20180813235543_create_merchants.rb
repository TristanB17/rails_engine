class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.text :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
