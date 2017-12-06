class Event < ApplicationRecord
  paginates_per 12

  has_attached_file :image, styles: { medium: "1280x720>", thumb: "640x360>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :name, presence: true

  belongs_to :artist, optional: true
  belongs_to :venue, optional: true
  has_many :images
  has_many :genres, through: :artist
  belongs_to :user, optional: true


  scope :random_event, -> { order("RANDOM()") }


  def pretty_date
    Time.at(self.date).strftime('%A, %B %d, %Y')
  end

  def pretty_time
    Time.at(self.date.to_i).strftime('%I:%M %p')
  end

  private

  def date_must_be_in_future
    current = Date.today
    if date != nil && date <= current
      errors.add(:date, "can't be in the past! You silly")
    end
  end

end
