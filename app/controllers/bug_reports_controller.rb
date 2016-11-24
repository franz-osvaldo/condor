class BugReportsController < ApplicationController
  def index
    @bug_reports = BugReport.all
  end

  def show
    @bug_report = BugReport.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def new
    @bug_report = BugReport.new
    respond_to do |format|
      format.js{}
    end
  end

  def create
    @bug_report = BugReport.new(bug_report_params)
    respond_to do |format|
      if @bug_report.save
        format.js{}
      end
    end
  end
  def update
    # render :text => params.inspect
    @bug_report = BugReport.find(params[:id])
    @bug_report.update_attribute(:state, @bug_report.state ? false : true)
    respond_to do |format|
      format.js{}
    end
  end


  private
  def bug_report_params
    params.require(:bug_report).permit(:report, :user_id, :state)
  end
end
