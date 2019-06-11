class Complaint < ApplicationRecord
   belongs_to :entity
   belongs_to :category
   belongs_to :user
   has_many :attachments
   has_many :comments
   has_many :reports
   has_many :likes, dependent: :destroy
   has_many_attached :media
   has_one_attached :main_image

   # Socialization Gem
   acts_as_likeable
   acts_as_followable

end
