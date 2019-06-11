class Comment < ApplicationRecord
   belongs_to :user
   belongs_to :complaint

   acts_as_mentionable

end
