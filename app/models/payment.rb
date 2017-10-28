class Payment < ApplicationRecord
  after_initialize :init

  belongs_to :account


  def init
    self.status ||= 'draft'
    self.description ||= ''
    self.date ||= Time.now
    self.amount ||= 0.0
    self.amount_requested ||= 0.0
    self.amount_received||= 0.0
    self.amount_fees||= 0.0
    self.guid ||= SecureRandom.uuid
  end
end