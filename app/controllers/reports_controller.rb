class ReportsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @reports = current_user.reports
  end

  def show
    @report = Report.find(params[:id])
    @subreports = @report.subreports
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(set_params) 
    if @report.save
      ReportUser.create(report_id: @report.id, user_id: current_user.id)
      flash[:notice] = "report created successfully"
      redirect_to @report
    else
      render 'new'
    end
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    already_asigned = @report.user_ids - [current_user.id]
    already_asigned.each do |id|
      ReportUser.find_by(user_id: id,report_id: @report.id).destroy
    end
    @report.update!(text: params[:report][:text])
    @report.users.where(id: already_asigned).destroy_all
    incoming_user = params[:report][:user_ids].compact_blank.map(&:to_i)
    incoming_user.each do |id|
      User.find(id).report_users.create!(report_id: @report.id) if current_user.id != id
    end

    current_user.reports.find(@report.id).update!(text: params[:report][:text])
      params[:report][:sub_ids].each do |id|
        @report.subreports << Report.find_by(id: id) if id.present?
      end
    redirect_to @report
  end

  def destroy
    @report = Report.find(params[:id])
    current_user.reports.destroy(@report)
    redirect_to reports_path
  end

  def report_users
    @report = Report.find(params[:id])
    @user = @report.users 
  end

  private

  def set_params
    params.require(:report).permit(:text)
  end
end