class Link < ApplicationRecord
  def generate_slug
    self.slug = self.id.to_s(36)
    self.save
  end

  def display_slug
    "http://localhost:3000/" + self.slug
  end

  after_create :generate_slug
end
