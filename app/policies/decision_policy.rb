# encoding: utf-8
class DecisionPolicy < ApplicationPolicy
  
  def update?
    @user.admin?
  end

  def create?
    @user.admin?
  end
  
  def destroy?
    @user.admin?
  end
end
  