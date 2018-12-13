class Board < ApplicationRecord
    has_many :tasks, dependent: :delete_all
    has_many :memberships, dependent: :delete_all
    has_many :users, :through => :memberships, dependent: :delete_all
    
    validates :name, :presence => true
end
