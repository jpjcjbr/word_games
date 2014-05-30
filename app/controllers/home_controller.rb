class HomeController < ApplicationController
  def index
  end

  def create
  	@text = params[:mad_lib_text]
  	@madLib = MadLib.create(:text => @text)
  	
  	render 'show'
  end

  def fill
  	@madLib = MadLib.create(:text => params[:mad_lib_text])

  	solution = @madLib.solutions.create

  	@madLib.parts_of_speech.each do |label, quantity|
  		(1..quantity).each do |i|
  			solution.fill_field("#{label.capitalize} (#{i})", :with => params["#{label}_#{i}"])
  		end
  	end

  	@result = solution.resolve

  	render 'result'
  end
end
