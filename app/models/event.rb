class Event < ApplicationRecord

  belongs_to :admin, foreign_key: 'admin_id', class_name: "User"
  has_many :participants, through: :attendances, class_name: 'User'
  has_many :attendances
  has_one_attached :event_picture

  validate :cant_start_in_the_past
  validate :duration_be_positive_and_multiple_of_5
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000}
  validates :price, presence: true
  validates_inclusion_of :price, :in => 1..1000
  validates :location, presence: true


  def duration_be_positive_and_multiple_of_5
    unless duration.present? && duration > 0 && duration % 5 == 0
      errors.add(:duration, "has to be positive and multiple of 5.")
    end
  end

  def cant_start_in_the_past
    unless start_date.present? && start_date > DateTime.now
      errors.add(:start_date, "must exist and can't be in the past")
    end
  end

end
