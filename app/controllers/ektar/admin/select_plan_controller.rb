# typed: false

module Ektar
  module Admin
    class SelectPlanController < ApplicationController
      before_action :authenticate_user!
      before_action :user_is_admin

      def new
        @plans = Ektar::Plan.all
        render "ektar/select_plan/new"
      end

      def create
        plan_id = params[:plan_id]

        if plan_id && current_organization.update(plan: Ektar::Plan.find_by(id: plan_id))
          redirect_to ektar.root_path, notice: t("flash.create.select_plan.notice")
        else
          @plans = Ektar::Plan.all

          flash.now[:alert] = t("flash.create.select_plan.alert")
          render :new
        end
      end

      private

      def user_is_admin
        redirect_to Ektar.configuration.root_app_path unless current_user.is_admin?(current_organization)
      end
    end
  end
end
