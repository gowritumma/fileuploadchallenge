class Upload < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: "user_id", inverse_of: :uploads

 
end
