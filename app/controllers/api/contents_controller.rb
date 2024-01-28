module Api 
  class ContentsController < ApplicationController
    protect_from_forgery with: :null_session
    # before_action :authenticate_user!
    
    def create
      @content = content.create(content_params)

      respond_to do |format|
        format.turbo_stream
      end
    end
    
    def update
      @content = Content.find(params[:id])
      @content.file.attach(content_params[:file])
      respond_to do |format|
        format.json do
          render json: {}, status: 200
        end
      end
    end

    def delete
      @content = Content.find(params[:id])
      @content.destroy
      respond_to do |format|
        format.json do
          render json: {}, status: 200
        end
      end
    end

    private
    
    def content_params
      params.require(:content).permit(:name, :file_type, :file_size)
    end
  end
end