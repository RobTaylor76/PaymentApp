class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :type
      t.string :status
      t.string :email
      t.string :description

      t.datetime :date
      t.datetime :paid_at

      t.decimal :amount_requested, :precision => 10 , :scale => 2
      t.decimal :amount_received, :precision => 10 , :scale => 2
      t.decimal :amount_fees, :precision => 10 , :scale => 2

      t.string :external_id
      t.string :guid

      t.timestamps
    end
  end
end
