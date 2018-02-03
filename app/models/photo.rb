class Photo < ApplicationRecord
  belongs_to :request
  serialize  :object
end
