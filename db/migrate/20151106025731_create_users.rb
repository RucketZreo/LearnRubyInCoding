class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :UserName
      t.string :EMail
      t.string :TelPhoneNo

      t.timestamps null: false
    end
  end
end
