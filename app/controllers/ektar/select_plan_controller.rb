# typed: false

module Ektar
  class SelectPlanController < ApplicationController
    def new
      @plans = Ektar::Plan.all
    end

    def create
      plan_id = params[:plan_id]

      if plan_id && current_organization.update(plan: Ektar::Plan.find_by(id: plan_id))
        redirect_to root_path, notice: t("flash.create.select_plan.notice")
      else
        @plans = Ektar::Plan.all

        flash.now[:alert] = t("flash.create.select_plan.alert")
        render :new
      end
    end
  end
end
