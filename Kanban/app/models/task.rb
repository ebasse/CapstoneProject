class Task < ApplicationRecord
    has_many :comments
    belongs_to :board
    belongs_to :user
end
