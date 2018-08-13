class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.text :name
      t.date :created_at
      t.date :updated_at
    end
  end
end
