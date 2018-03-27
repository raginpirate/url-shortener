class Link < ApplicationRecord
  def generate_slug
    self.slug = self.id.to_s(36)
    self.save
  end

  def display_slug
    "https://boiling-dusk-22777.herokuapp.com/" + self.slug
  end

  after_create :generate_slug
end
