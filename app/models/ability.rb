class Ability
  include CanCan::Ability

  def initialize(user)

    return unless user

    can :manage, :all if user.manager?
    cannot :manage, Permission if user.manager?

    can :manage, :all if user.admin?

  end
end
