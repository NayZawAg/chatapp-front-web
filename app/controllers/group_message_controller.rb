class GroupMessageController < ApplicationController
  include FaradayApiClient
  include ActionView::Helpers::SanitizeHelper

  def show
    #check unlogin user

    if session[:s_channel_id].nil?
      redirect_to home_url
    elsif params[:session][:message].blank?
      redirect_to m_channel_path(session[:s_channel_id])
    else
      message = params[:session][:message]
      draft_status = params[:session][:draft_status]
      mention_name =params[:session][:memtion_name] 
      data = {
        "message": message,
        "s_channel_id": session[:s_channel_id],
        "mention_name": [mention_name],
        "draft_message_status": draft_status,
      };
      post_data("/groupmsg", data)
     
      redirect_to m_channel_path(session[:s_channel_id])
    end
  end

  def showthread
    if session[:s_group_message_id].nil?
      unless session[:s_channel_id].nil?
        redirect_to m_channel_path(session[:s_channel_id])
      end
    elsif session[:s_channel_id].nil?
      redirect_to home_url
    elsif params[:session][:message].blank?
      redirect_to t_group_message_path(session[:s_group_message_id])
    else
      message = params[:session][:message]
      draft_status = params[:session][:draft_status]
      memtion_name = params[:session][:memtion_name] 
      data = {
        "s_group_message_id": session[:s_group_message_id],
        "s_channel_id": session[:s_channel_id],
        "message": message,
        "mention_name": [memtion_name],
        "draft_message_status": draft_status,
      };
      post_data("/groupthreadmsg", data)
      redirect_to t_group_message_path(session[:s_group_message_id])
    end
  end

  def deletemsg
    if session[:s_channel_id].nil?
      redirect_to home_url
    else  
      get_data("/delete_groupmsg?s_channel_id=#{session[:s_channel_id]}&id=#{params[:id]}&user_id=#{session[:current_user_id]}")
      redirect_to m_channel_path(session[:s_channel_id])
    end
  end

  def deletethread
    if session[:s_channel_id].nil?
      redirect_to home_url
    else
      get_data("/delete_groupthread?s_channel_id=#{session[:s_channel_id]}&id=#{params[:id]}&s_group_message_id=#{session[:s_group_message_id]}")
      redirect_to t_group_message_path(session[:s_group_message_id])
    end
  end

  # edit message 
  def edit
    if params[:id].nil?
      redirect_to home_url
    else
      response = get_data("/groupmsg/edit/#{params[:id]}")
      @dataraw = response["message"]["groupmsg"]
      @data = sanitize(@dataraw, tags: %w(p span div br strong em a blockquote s ul ol li), attributes: %w(href class style))
      retrieve_group_message
      retrievehome
      render "group_show/_edit"
    end
  end

  def update
    if params[:action_type] == 'send' || params[:session][:draft_status]
      id = params[:id]
      message = params[:session][:message]
      data = {
        id: id,
        message: message
      }
      post_data( "update_groupmsg", data)
      redirect_to m_channel_path(session[:s_channel_id])
    else
      redirect_to m_channel_path(session[:s_channel_id])
    end
  end

  def edit_thread
    if params[:id].nil?
      redirect_to home_url
    else
      response = get_data("/groupthreadmsg/edit/#{params[:id]}")
      @dataraw = response["message"]["groupthreadmsg"]
      @data = sanitize(@dataraw, tags: %w(p span div br strong em a blockquote s ul ol li), attributes: %w(href class style))
      retrieve_group_thread
      retrievehome
      render "group_thread_show/_editthread"
    end
  end
  
  def update_thread
    if params[:action_type] == 'send' || params[:session][:draft_status]
      id = params[:id]
      message = params[:session][:message]
      data = {
        id: id,
        message: message
      }
      post_data( "update_groupthreadmsg", data)
      redirect_to t_group_message_path(session[:s_group_message_id])
    else
      redirect_to t_group_message_path(session[:s_group_message_id])
    end
  end
end
