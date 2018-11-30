class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :memberships
  has_many :members, through: :memberships
  
  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end
  
  def self.search(param)
    param.strip!
    param.downcase!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end
  
  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end
  
  def not_members_with?(member_id)
    memberships.where(member_id: member_id).count < 1
  end
  
end
