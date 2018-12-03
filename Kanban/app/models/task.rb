class Task < ApplicationRecord
    has_many :comments, dependent: :delete_all
    belongs_to :board
    belongs_to :user, optional: true
end
