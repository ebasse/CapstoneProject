class Task < ApplicationRecord
    has_many :comments, dependent: :delete_all
    belongs_to :board
end
