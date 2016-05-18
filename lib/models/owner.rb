class Owner < ActiveRecord::Base
  self.primary_key = 'id'

  has_many :contacts
end