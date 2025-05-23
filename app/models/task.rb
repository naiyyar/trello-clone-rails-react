class Task < ApplicationRecord
  belongs_to :list
  validates :title, presence: true

  include RankedModel
  ranks :row_order, with_same: [:list_id]

end
