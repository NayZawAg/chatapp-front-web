class StaticPagesController < ApplicationController
  include FaradayApiClient
  before_action :check_token, only: [:home]
  def welcome
    if session[:token].present? && session[:current_user_id].present?
      response = get_data("/main")
      if response['error'] == 'Invalid token'
        flash[:danger] = 'session expire! Please login again.' || 'Unknown error occurred'
        redirect_to '/logout'
      else
        redirect_to home_url
      end
    end
  end

  def home
    session.delete(:s_user_id)
    session.delete(:s_channel_id)
    session.delete(:s_direct_message_id)
    session.delete(:s_group_message_id)
    session.delete(:r_direct_size)
    session.delete(:r_group_size)

    # ここに必要なデータをAPIから取得する
    retrievehome
  end
end
