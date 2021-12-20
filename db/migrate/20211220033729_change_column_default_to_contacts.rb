class ChangeColumnDefaultToContacts < ActiveRecord::Migration[6.1]
  def change
    change_column_default :contacts, :subject, from: 0, to: nil
  end
end
