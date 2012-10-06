STV3::Application.routes.draw do

  # -------------------------------------------------------
  # default route to the region index page
  root :to => 'regions#index'

  # -------------------------------------------------------
  # static pages of supporting information
  match 'search'   => 'pages#search'
  match 'privacy'  => 'pages#privacy'
  match 'contact'  => 'pages#contact'
  
  # -------------------------------------------------------
  # specific resource routes
  resources :regions
  resources :programs
  #resources :rules
  #resources :channels
  #resources :sports
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
