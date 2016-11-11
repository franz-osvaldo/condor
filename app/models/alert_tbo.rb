class AlertTbo < ApplicationRecord
  belongs_to :fleet
  belongs_to :tbo
  after_create :send_warning
  after_update :send_accomplished

  def send_warning
    UserMailer.tbo_warning(User.where(receiver: true).map{|e| e.email}, self).deliver
  end

  def send_accomplished
    UserMailer.tbo_accomplished(User.where(receiver: true).map{|e| e.email}, self).deliver
  end
end


