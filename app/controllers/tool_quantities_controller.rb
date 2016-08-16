class ToolQuantitiesController < ApplicationController
  helper_method :sort_col, :sort_dire
  def assets
    @assets = ToolQuantity.where('asset = ?', true).joins(:tool).order(sort_col+' '+sort_dire)
    @no_available = @assets.where('quantity_available = ?', 0).count
    flash.now[:tools] = 'in'
  end

  def loaned_tools_list
    # render :text => params.inspect
    @tools = ToolQuantity.where('quantity_available = ? AND asset = ?', 0, true).joins(:tool).order(sort_col+' '+sort_dire)
    flash.now[:tools] = 'in'
  end

  def history_report
    @history_report = (BorrowedTool.all + ReturnedTool.all)
    flash.now[:tools] = 'in'
  end

  def get_custodians
    respond_to do |format|
      format.json{ render :json => User.all.to_json(only: [:id, :name])}
    end
  end

  def user_history
    @user = User.find(params[:id])
    @borrowed_tools = @user.borrowed_tools
    @returned_tools = @user.returned_tools
    @history_report = @borrowed_tools + @returned_tools
    respond_to do |format|
      format.js{}
    end
  end
  private
  def sort_col
    params[:sort] || 'part_number'
  end

  def sort_dire
    params[:direction] || 'asc'
  end
end
