# frozen_string_literal: true

# Home Controller
class HomeController < ApplicationController
  def index; end

  def zipcode
    @zipcode_query = params[:zipcode]
    @url = "http://api.weatherapi.com/v1/current.json?key=80ece6c16a9d42b58b1112152212211&q=#{@zipcode_query}"
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    if @output['error'] || @zipcode_query == ''
    elsif @output['location']['country'] == 'UK'
      @final_output = @output['current']['temp_c']
      @final_output_location = @output['location']['name']
      @final_temperature_status = temperature_check(@final_output)
    end
  end

  private

  def temperature_check(temp)
    if temp > 27
      'Hot'
    elsif temp > 17 && temp < 27
      'Warm'
    else
      'Cold'
    end
  end
end
