class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  belongs_to :parent, class_name: "Comment", optional: true
  has_many   :childrens, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  has_rich_text :content

  def authored_by?(user)
    self.user == user
  end
end
