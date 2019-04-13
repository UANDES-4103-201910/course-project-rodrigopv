class Entity < ApplicationRecord
   has_many :complaints
   belongs_to :entity_type
end
