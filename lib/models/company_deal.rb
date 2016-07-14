# frozen_string_literal: true
#:nodoc
class CompanyDeal < ActiveRecord::Base
  belongs_to :company
  belongs_to :deal
end
