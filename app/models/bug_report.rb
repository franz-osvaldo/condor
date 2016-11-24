class BugReport < ApplicationRecord
  belongs_to :user
  after_create :send_bug

  def send_bug
    UserMailer.bug_report(self.report).deliver_now
  end
end
