# frozen_string_literal: true

class Skill < ApplicationRecord
  includes Placeholder
  validates_presence_of :title, :percentage

  after_initialize :set_defaults

  def set_defaults
    self.badge ||= Placeholder.image_generator(height: '250', width: '250')
  end
end
