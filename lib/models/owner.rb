# frozen_string_literal: true
#:nodoc
class Owner < ActiveRecord::Base
  self.primary_key = 'id'

  has_many :contacts

  def full_name
    [first, last].join('')
  end
end
