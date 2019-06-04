class State < ApplicationRecord
  has_many :counties, class_name: 'County', dependent: :destroy

end
