Rails.application.routes.draw do
  root "static_pages#welcome"
  get "welcome" => "static_pages#welcome"

  get "workspace" => "m_workspaces#new"

  get "signin" => "sessions#new"
  post "signin" => "sessions#create"

  get "change_password" => "change_password#new"

  post "profile_upload" => "m_users#profile_upload"

  get "home" => "static_pages#home"

  get "memberinvite" => "member_invitation#new"
  post "memberinvite" => "member_invitation#invite"
  get "confirminvitation" => "m_users#confirm"

  get "channelcreate" => "m_channels#new"
  post "channelcreate" => "m_channels#create"

  get "channeledit" => "m_channels#edit"
  get "delete_channel" => "m_channels#delete"
  post "channelupdate" => "m_channels#update"

  get "star" => "t_direct_star_msg#create"
  get "unstar" => "t_direct_star_msg#destroy"
  get "starthread" => "t_direct_star_thread#create"
  get "unstarthread" => "t_direct_star_thread#destroy"

  get "delete_directmsg" => "direct_message#deletemsg"
  get "delete_directthread" => "direct_message#deletethread"

  get "delete_groupmsg" => "group_message#deletemsg"
  get "delete_groupthread" => "group_message#deletethread"

  get "groupstar" => "t_group_star_msg#create"
  get "groupunstar" => "t_group_star_msg#destroy"
  get "groupstarthread" => "t_group_star_thread#create"
  get "groupunstarthread" => "t_group_star_thread#destroy"

  get "starlists" => "star_lists#show"
  get "thread" => "thread#show"
  get "mentionlists" => "mention_lists#show"
  get "allunread" => "all_unread#show"
  get "draftlists" => "draft_lists#show"

  get "usermanage" => "user_manage#usermanage"
  get "edit" => "user_manage#edit"
  get "update" => "user_manage#update"

  get "channeluser" => "channel_user#show"
  get "channeluseradd" => "channel_user#create"
  get "channeluserdestroy" => "channel_user#destroy"
  get "channeluserleave" => "channel_user#leave"
  get "channeluserjoin" => "channel_user#join"

  post 'directmsg' => 'direct_message#show'
  post 'directthreadmsg' => 'direct_message#showthread'
  post 'directthreadmsgdirectly' => 'direct_message#showthreaddirectly'
  
  post 'groupmsg' => 'group_message#show'
  post 'groupthreadmsg' => 'group_message#showthread'
  post 'groupthreadmsgdirectly' => 'group_message#showthreaddirectly'

  get "refresh" => "sessions#refresh"

  get "refresh_direct" => "m_users#refresh_direct"
  get "refresh_group" => "m_channels#refresh_group"

  delete 'logout' =>  'sessions#destroy'
  get 'logout' => 'sessions#destroy'
  
  # edit username
  get "useredit" => "m_users#edituser"
  patch "useredit" => "m_users#updateuser"

  # edit direct message
  get "/directmsg/edit/:id" => "direct_message#edit", as: "edit_directmsg"
  post "update_directmsg" => "direct_message#update"
  # edit direct thread
  get "/directthreadmsg/edit/:id" => "direct_message#edit_thread", as: "edit_directthreadmsg"
  post "update_directthreadmsg" => "direct_message#update_thread"
  # edit group message
  get "/groupmsg/edit/:id" => "group_message#edit", as: "edit_groupmsg"
  post "update_groupmsg" => "group_message#update"
  # edit group thread
  get "/groupthreadmsg/edit/:id" => "group_message#edit_thread", as: "edit_groupthreadmsg"
  post "update_groupthreadmsg" => "group_message#update_thread"

  # start routes for direct react
  post "directreact" => "t_direct_react_msg#create"
  get "directreact" => "t_direct_react_msg#create"

  post "directthreadreact" => "t_direct_react_thread#create"
  get "directthreadreact" => "t_direct_react_thread#create"
  # end routes for direct react

  # start routes for group react
  post "groupreact" => "t_group_react_msg#create"
  get "groupreact" => "t_group_react_msg#create"

  post "groupthreadreact" => "t_group_react_thread#create"
  get "groupthreadreact" => "t_group_react_thread#create"
  # end routes for group react

  resources :m_workspaces
  resources :m_users
  resources :m_channels
  resources :t_direct_messages
  resources :t_group_messages
end
