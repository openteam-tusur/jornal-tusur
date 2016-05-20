class Ability
  include CanCan::Ability

  def initialize(user)

    return unless user

    can :manage, [Issue] if user.manager?

    can :manage, :all if user.admin?

  end
end
