class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    validates :title, uniqueness: true, presence: true
    validates :body, length:{minimum: 50}
end
