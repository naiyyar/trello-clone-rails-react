class List < ApplicationRecord
  include RankedModel
  ranks :row_order, with_same: [:board_id]

  belongs_to :board
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
end
