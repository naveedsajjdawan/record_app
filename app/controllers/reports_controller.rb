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
       ReportUser.create(report_id: @report.id, user_id:current_user.id)
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
    @report.subreports << Report.find_by(id: params[:report][:sub_ids][1]) 
    params[:report][:user_ids].compact_blank.each do |id|
      user = User.find_by(id: id)
      if user.report_ids.include?(@report.id)
        @report.update!(text: params[:report][:text])
      else
        # user.reports.create!(text: params[:report][:text])
        ReportUser.create!(user_id: user.id, report_id: @report.id)
      end
    end
    redirect_to @report
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
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