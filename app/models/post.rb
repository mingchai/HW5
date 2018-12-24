class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    belongs_to :user
    validates :title, uniqueness: true, presence: true
    validates :body, length:{minimum: 50}
end
