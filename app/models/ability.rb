class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is_admin?
      can :manage, :all
    elsif user.is_user?
      can :manage, Absent, :user_id => user.id
      can :manage, User, :id => user.id
      can :manage, AbsentPermission, :user_id => user.id
      can :manage, LoanPermission, :user_id => user.id
      can :manage, Overtime, :user_id => user.id

      can [:new, :create, :index], Absent, :user_id => user.id
      can [:show, :new, :create, :edit, :update], User, :id => user.id
      can [:new, :create, :show, :index], AbsentPermission, :user_id => user.id
      can [:new, :create, :show, :index], LoanPermission, :user_id => user.id
      can [:new, :create, :show, :index], Overtime, :user_id => user.id

      can :manage, LoanPayment, :user_id => user.id
      can :manage, AllowanceClaimTransaction
    else

    end

  end
end
