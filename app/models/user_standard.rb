class UserStandard < ActiveRecord::Base
    belongs_to :user
    belongs_to :standard
end
