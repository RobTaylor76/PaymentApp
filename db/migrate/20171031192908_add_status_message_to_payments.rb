class AddStatusMessageToPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :status_message, :text
  end
end
