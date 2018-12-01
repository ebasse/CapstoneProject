class Membership < ApplicationRecord
    belongs_to :user
    belongs_to :member, :class_name => 'User'
    has_one :board
end
