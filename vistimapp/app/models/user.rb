class User < ApplicationRecord
   has_many :complaints
   has_many :comments
   has_many :reports
end
