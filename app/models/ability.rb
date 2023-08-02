class Ability
  include CanCan::Ability
  def initialize(user)
    if user.client?
      can :manage, Client
      can :read, Trainer
      can [:create, :update], Rating
      can [:create, :read, :destroy], Comment
      can :create, Appointment
    elsif user.trainer?
      can :manage, Trainer
      can :manage, Post
      can [:read, :destroy], Comment
      can :read, Client
      can [:confirm, :reject], Appointment
    end
  end
end
