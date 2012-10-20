class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #log = Logger.new(File.expand_path("#{Rails.root}/log/controller.log", __FILE__))
  #log.info("I can log from the application controller")
  
  protected
    def authenticate
      basic_auth_yaml = YAML.load_file(File.expand_path("#{Rails.root}/config/basic_auth.yml", __FILE__))
      
      #log = Logger.new(File.expand_path("#{Rails.root}/log/controller.log", __FILE__))
      #log.info("The username is #{basic_auth_yaml["username"]}")
      
      authenticate_or_request_with_http_basic do |username, password|
        username == basic_auth_yaml["username"] && password == basic_auth_yaml["password"]
      end
    end
    
end
