class Listing < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  #  Place the enum BEFORE validations
  CATEGORIES = %w[electronics clothing books other]


  validates :name, presence: true
  validates :price, presence: true
  validates :image, presence: true
  has_many :messages

end
