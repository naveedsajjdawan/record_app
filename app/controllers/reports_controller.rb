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
    current_user.reports.find_by(id: @report.id).update!(text: params[:report][:text])
      params[:report][:sub_ids].each do |id|
        @report.subreports << Report.find_by(id: id) if id.present?
      end
    params[:report][:user_ids].compact_blank.each do |id|
      user = User.find_by(id: id)
      if user.report_ids.include?(@report.id)
        @report.update!(text: params[:report][:text])
      else
        @report.report_users.create!(user_id: user.id)
      end
    end
    redirect_to @report
  end

  def destroy
    @report = Report.find(params[:id])
    del_report = []
    user_reports = current_user.report_ids
    del_report << params[:id].to_i
    updated_report = user_reports - del_report
    current_user.update(report_ids: updated_report)
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
  # def user_destroy
  #   @report = ReportUser.find_by(report_id: @report.id, user_id: user.id)
  #   @report.destroy
  # end
end