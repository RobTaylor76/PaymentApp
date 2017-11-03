class Payment < ApplicationRecord
  after_initialize :init

  belongs_to :account

  validates  :amount, :numericality => {greater_than_or_equal_to: 1.00}
  validates :email, :presence => true
  validates :description, :presence => true

  def amount_in_pence
    (self.amount * 100.0).to_i
  end

  def draft?
    status == 'draft'
  end

  def paid?
    status == 'paid'
  end

  def failed?
    status == 'failed'
  end

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