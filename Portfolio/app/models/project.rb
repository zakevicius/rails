# frozen_string_literal: true

class Project < ApplicationRecord
  includes Placeholder

  has_many :technologies
  accepts_nested_attributes_for :technologies, reject_if: lambda { |attrs| attrs['name'].blank? }
  
  validates_presence_of :title, :body, :main_image, :thumb_image

  after_initialize :set_defaults

  scope :rails, -> { where(subtitle: 'Ruby on Rails') }

  ### Another way to define scope
  def self.react
    where(subtitle: 'React')
  end

  def set_defaults
    self.main_image ||= Placeholder.image_generator(height: '600', width: '400')
    self.thumb_image ||= Placeholder.image_generator(height: '350', width: '200')
  end
end
