class Api::RushingsController < ApplicationController
  before_action :filter_records

  def index
    render json: { rushings: @rushings }
  end

  def download
    csv_data = DownloadService.generate_csv(@rushings)
    send_data csv_data, filename: "rushings-#{Time.current.to_i}.csv"
  end

  private 

  def filter_records
    @rushings = Rushing.all 
  end
end
