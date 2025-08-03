class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  ROLES = { buyer: 0, seller: 1 }

  enum :role, ROLES
  has_many :listings
  # app/models/user.rb
  has_many :sent_messages, class_name: "Message", foreign_key: "buyer_id"
  has_many :received_messages, class_name: "Message", foreign_key: "seller_id"



end
