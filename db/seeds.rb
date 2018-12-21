# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Post.destroy_all
Comment.destroy_all
User.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('posts')
ActiveRecord::Base.connection.reset_pk_sequence!('comments')
ActiveRecord::Base.connection.reset_pk_sequence!('users')

50.times do
    p = Post.create(
        title:Faker::Lovecraft.sentence(1),
        body: Faker::Lovecraft.paragraph(1)
    )
    if p.valid?
        rand(1..15).times do
            p.comments << Comment.new( #comments to be associated with the post
                body:Faker::Company.bs
            )
        end
    end
end

100.times do
    User.create(
        name: Faker::FunnyName.name,
        email: Faker::Internet.email,
        password: "1"
    )
end

posts = Post.all
comments = Comment.all
users = User.all
puts "#{posts.count} posts were created"
puts "#{comments.count} comments were created"
puts "#{users.count} users were created"