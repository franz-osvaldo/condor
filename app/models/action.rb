class Action < ApplicationRecord
  belongs_to :scheduled_inspection, inverse_of: :actions
  has_many :procedures, inverse_of: :action, dependent: :destroy
  has_many :tasks, through: :procedures, inverse_of: :actions
  has_many :time_limits, inverse_of: :action, dependent: :destroy
  accepts_nested_attributes_for :time_limits
  before_save :mark_addresses_for_removal

  def mark_addresses_for_removal
    time_limits.each do |time_limit|
      time_limit.mark_for_destruction if time_limit.time.blank?
    end
  end
end

