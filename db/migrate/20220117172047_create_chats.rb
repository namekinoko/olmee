class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.text :message
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
