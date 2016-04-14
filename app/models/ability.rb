class Ability # :nodoc:
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is_admin?
      can :manage, :all
    elsif user.is_user?
      can [:new, :create, :index], Absent, :user_id => user.id
      can [:list_claim], Reimbursement, :reimbursement_id => user.id
      can [:detail], AccountReceivable, :account_receivable_id => user.id
      can [:show, :new, :create, :edit, :update], User, :id => user.id
      can [:new, :create, :show, :index], AbsentPermission, :user_id => user.id
      can [:new, :create, :show, :index], LoanPermission, :user_id => user.id
      can [:new, :create, :show, :index], Overtime, :user_id => user.id
      can [:my_point], PointHistory, :point_history_id => user.id
      can :manage, LoanPayment
      can :manage, AllowanceClaimTransaction
    else

    end

  end
end
