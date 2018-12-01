class Board < ApplicationRecord
    has_many :tasks, dependent: :delete_all
    belongs_to :membership
end
