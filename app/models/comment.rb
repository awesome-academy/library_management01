class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, presence: true, allow_blank: false,
    length: {maximum: Settings.comment.content.max_length}

  scope :_page,
    ->(page){paginate page: page, per_page: Settings.paginate.per_page}
  scope :order_by_created_at, ->{order "created_at DESC"}
end
