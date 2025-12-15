class Post < ApplicationRecord
  ## VALIDATIONS
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }

  ## ASSOCIATIONS
  has_rich_text :content
end
