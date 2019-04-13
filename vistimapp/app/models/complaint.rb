class Complaint < ApplicationRecord
   belongs_to :entity
   belongs_to :category
   belongs_to :user
   has_many :attachments
   has_many :comments
   has_many :reports
end
