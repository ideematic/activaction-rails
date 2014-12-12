class LabelsController < ApplicationController
  private
  def label_params
    params.require(:label).permit(:content, :label)
  end
end