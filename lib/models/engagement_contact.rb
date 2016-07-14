# frozen_string_literal: true
#:nodoc
class EngagementContact < ActiveRecord::Base
  belongs_to :engagement
  belongs_to :contact
end
