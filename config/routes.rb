STV3::Application.routes.draw do

  # -------------------------------------------------------
  # default route to the region index page
  root :to => 'regions#index'

  # -------------------------------------------------------
  # static pages of supporting information
  match 'About'    => 'pages#about'
  match 'Login'    => 'pages#login'
  match 'Dashboard'=> 'pages#dashboard'
  match 'Privacy'  => 'pages#privacy'
  match 'Contact'  => 'pages#contact'
  
  # -------------------------------------------------------
  # specific resource routes
  resources :regions, :only => [:index, :show]
  resources :programs
  resources :rules
  resources :sports, :only => [:show]
  resources :channels, :only => [:index, :show]
  #resources :log_entries
  #resources :raw_channels 
  #resources :raw_programs
  
  # -------------------------------------------------------
  # special routes - these need to be last // catch all
  
  # special routes for /region
  match ':id' => 'regions#show'
    
  # special route for /region/sport
  match ':region/:sport' => 'programs#index'

end
