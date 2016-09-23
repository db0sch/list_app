class ActivitiesController < ApplicationController

  def index
    @activities = policy_scope(PublicActivity::Activity).order('created_at desc').where(owner: current_user.all_following, owner_type:"User")
  end

end
