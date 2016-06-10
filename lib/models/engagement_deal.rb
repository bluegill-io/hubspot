#:nodoc
class EngagementDeal < ActiveRecord::Base
  belongs_to :deal
  belongs_to :engagement
end
