class Like < ApplicationRecord
    belongs_to :emomusic
    belongs_to :user
    counter_culture :emomusic
    validates :user_id, presence: true
    validates :emomusic_id, presence: true
end
