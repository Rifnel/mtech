class participant < ActiveRecord::base
	belongs_to :conversation
	belongs_to :user

	has_many :conversations
end