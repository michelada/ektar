# typed: false

module Ektar
  class SelectPlanController < ApplicationController
    def new
      @plans = Ektar::Plan.all
      @organization = current_organization
    end

    def create
      plan_id = params.dig(:plan, :id)

      if current_organization.update(plan: Ektar::Plan.find_by(id: plan_id))
        redirect_to root_path
      else
        render :new
      end
    end
  end
end
