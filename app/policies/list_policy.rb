# encoding: utf-8

class ListPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

  def vote?
    !record.selection.lists.map{|list| list.voters.pluck(:id)}.flatten.include?(user.id)
  end
end
