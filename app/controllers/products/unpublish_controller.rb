module Products
  class UnpublishController < ApplicationController
    before_action :authenticate_user!

    def update
      @product = Product.friendly.find(params[:id])
      @product.update(published: false)
      flash[:success] = 'Product successfully unpublished!'
      redirect_to edit_product_path(@product)
    end
  end
end