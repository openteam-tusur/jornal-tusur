class Ability
  include CanCan::Ability

  def initialize(user)

    return unless user

    if user.manager?
      can :manage, :all
      cannot :manage, Permission
    end

    can :manage, :all if user.admin?

  end
end
