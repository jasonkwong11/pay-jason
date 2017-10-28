class CreateOrder < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :source_id
      t.integer :amount
      t.string :client_secret
      t.integer :created
      t.string :currency, default: "usd"
      t.boolean :livemode
      t.string :owner_address
      t.string :owner_email
      t.string :owner_name
      t.string :owner_phone
      t.string :verified_address
      t.string :verified_email
      t.string :verified_name
      t.string :verified_phone
      t.string :status
      t.string :payment_type
      t.string :usage
      t.string :alipay_statement_descriptor
      t.string :alipay_native_url
      t.string :alipay_data_string
    end
  end
end
