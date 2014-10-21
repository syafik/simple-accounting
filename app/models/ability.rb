class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is_admin?
      can :manage, :all
    elsif user.is_user?
      can :manage, Absent
      can :manage, User, :id => user.id
      can :manage, AbsentPermission, :user_id => user.id
      can :manage, LoanPermission, :user_id => user.id
      can :manage, Overtime, :user_id => user.id
      can :manage, LoanPayment, :user_id => user.id
      can :manage, AllowanceClaimTransaction
    else

    end

  end
end
