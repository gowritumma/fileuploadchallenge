class County < ApplicationRecord
  belongs_to :state, class_name: 'State', foreign_key: "state_id"

end
