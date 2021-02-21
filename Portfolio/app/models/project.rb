# frozen_string_literal: true

class Project < ApplicationRecord
  validates_presence_of :title, :body, :main_image, :thumb_image

  after_initialize :set_defaults

  scope :rails, -> { where(subtitle: 'Ruby on Rails') }

  ### Another way to define scope
  def self.react
    where(subtitle: 'React')
  end

  def set_defaults
    self.main_image ||= 'https://via.placeholder.com/600x400'
    self.thumb_image ||= 'https://via.placeholder.com/350x200'
  end
end
