# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


use rails secrets for SALT & KEY

stripe + paypal info will be encrypted at rest in the database

class User < ApplicationRecord
  before_save :encrypted_consumer_key
  
  private
   def encrypted_consumer_key
     salt = ENV['SALT'] # We save the value of: SecureRandom.random_bytes(64)
     key = ENV['KEY']   # We save the value of: ActiveSupport::KeyGenerator.new('password').generate_key(salt)
     crypt = ActiveSupport::MessageEncryptor.new(key)
     consumer_key = self.consumer_key # Input value from our form
     encrypted_data = crypt.encrypt_and_sign(consumer_key) # or crypt.encrypt_and_sign(self.consumer_key)
     self.consumer_key = encrypted_data
     # You can refactor to make these steps shorter.
   end
end


salt = SecureRandom.random_bytes(64) # Some value. Copy then save
key = ActiveSupport::KeyGenerator.new('password').generate_key(salt) # Some value. Copy then save

# In your controller or model
crypt = ActiveSupport::MessageEncryptor.new(ENV['KEY'])
consumer_key = User.find(1).consumer_key
puts crypt.decrypt_and_verify(consumer_key) # Original value!