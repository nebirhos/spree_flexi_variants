module Spree
  class Admin::CustomizedProductOptionsController < Spree::Admin::BaseController

    respond_to :html, :js

    def destroy
      @option = CustomizedProductOption.find_by_id(params[:id])
      if @option && @option.destroy
        @order = @option.product_customization.line_item.order
        respond_with(@option) do |format|
          format.js { render :text => "" }
        end
      else
        respond_with(@option) do |format|
          format.js { render :text => I18n.t(:destroy_customization_image_error), :layout => false }
        end
      end
    end

  end
end
