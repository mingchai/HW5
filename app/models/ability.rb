class Ability
  include CanCan::Ability

  def initialize(user)

      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
        can :read, :all
      end

      alias_action(:create, :read, :update, :edit, :delete, as: :crud)
      can(:crud, Post) do |post|
        post.user == user
      end

      can(:crud, Comment) do |comment|
        comment.user == user
      end
    
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
