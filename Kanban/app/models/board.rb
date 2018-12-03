class Board < ApplicationRecord
    has_many :tasks, dependent: :delete_all
    has_many :memberships
    has_many :users, :through => :memberships
    
    validates :name, :presence => true
end
