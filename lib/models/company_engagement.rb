#:nodoc
class CompanyEngagement < ActiveRecord::Base
  belongs_to :engagement
  belongs_to :company
end
