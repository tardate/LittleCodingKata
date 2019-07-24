class Time::NowController < ApplicationController
  before_action :get_time

  def show
    respond_to do |format|
      format.html
      format.json { render json: time_data }
      format.xml { render xml: time_data.to_xml(root: 'time') }
      format.text { render plain: @time }
    end
  end

  protected

  def get_time
    @time = Time.now.utc.iso8601
  end

  def time_data
    {
      iso8601: @time
    }
  end
end
