# app/controllers/sample_controller.rb
class SampleController < ApplicationController
  def inline
  end

  def square
    @params = params.permit(:color)
  end
end
