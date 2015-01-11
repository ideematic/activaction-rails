class LabelsController < ApplicationController

  protect_from_forgery :except => [:update]

  def update
    @label = Label.where(label: label_params[:label]).first_or_create
    @label.content = label_params[:content]
    @label.save
    render json: {success: true}
  end

  private
  def label_params
    params.require(:label).permit(:content, :label)
  end
end