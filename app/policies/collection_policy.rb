class CollectionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    # everyone can access a collection (whether it's public, open or private)
    true
    # (record.is_public_or_open? == true) || (record.user == user)
  end

  def create?
    true
  end

  def update?
    record.user == user
    # - record: the collection passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

  def destroy?
    record.user == user
  end

  def like?
    true
  end

  def follow?
    true
  end
end
