class Project < ApplicationRecord
  validates_presence_of :title, :body, :main_image, :thumb_image

  scope :rails, -> { where(subtitle: 'Ruby on Rails') }

  def self.react
    where(subtitle: 'React')
  end
end
