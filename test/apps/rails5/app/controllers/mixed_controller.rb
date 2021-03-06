class BaseController < ActionController::Base
  # No protect_from_forgery call, but one mixed in
  include ForgeryProtection
  include Concerning

  Statistics::AdminWithdrawal::BANK_LIST = [:deutsche, :boa, :jpm_chase, :cyprus]

  def another_early_return
    bank_name = params[:filename].first
    unless Statistics::AdminWithdrawal::BANK_LIST.include?(bank_name)
      flash[:alert] = 'Invalid filename'
      redirect_to :back
      return
    end

    Statistics::AdminWithdrawal.send("export_#{bank_name}_#inc!")
  end
end
