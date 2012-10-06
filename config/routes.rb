STV3::Application.routes.draw do

  # -------------------------------------------------------
  # default route
  root :to => 'pages#home'

  # -------------------------------------------------------
  # static pages
  match '/search',        :to => 'pages#search'
  match '/privacy',       :to => 'pages#privacy'
  match '/contact',       :to => 'pages#contact'
  
  # -------------------------------------------------------
  # specific resource routes
  resources :programs
  resources :rules
  resources :channels
  resources :sports
  resources :regions
  #resources :log_entries
  #resources :raw_channels 
  #resources :raw_programs
  
  # -------------------------------------------------------

end
