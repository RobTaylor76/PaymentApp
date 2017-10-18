class CreateAccount < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.text :stripe_pk#_enc
      t.text :stripe_sk#_enc
      t.text :paypal_client#_id_enc
      t.text :paypal_secret#_enc
      t.timestamps
    end
  end
end
