class ResourcePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.collection.user == user
    # - record: the collection passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

  def destroy?
    record.collection.user == user
  end

  def upvote?
    true
  end

  def downvote?
    true
  end

end
