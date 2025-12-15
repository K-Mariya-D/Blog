class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :photos

  has_rich_text :content

end
