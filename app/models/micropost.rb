class Micropost < ActiveRecord::Base
    belongs_to :user

    # order statement as lambda
    default_scope -> { order('created_at DESC') }
    validates :content, presence: true, length: { maximum: 140 }
    validates :user_id, presence: true
end
