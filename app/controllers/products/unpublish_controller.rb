module Products
  class UnpublishController < ApplicationController
    before_action :authenticate_user!

    def update
      @product = Product.friendly.find(params[:id])
      @product.update(published: false)

      respond_to do |format|
        format.turbo_stream do
          flash[:success] = 'Product successfully unpublished!'

          render turbo_stream: [turbo_stream.update('publish-button', partial: 'products/publish_button', locals: { product: @product })]
        end
      end
    end
  end
end