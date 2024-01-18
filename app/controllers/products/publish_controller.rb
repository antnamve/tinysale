module Products
  class PublishController < ApplicationController
    before_action :authenticate_user!
    
    def update
      @product = Product.friendly.find(params[:id])
      @product.update(published: true)
      flash[:success] = 'Product successfully published!'
      redirect_to edit_product_path(@product)
    end
  end
end