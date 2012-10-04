# ************************************************************************
# ** script to clean up the database including deletions of old stuff   **
# ** created DB 04/10                                                   **
# ************************************************************************

# required libraries
require 'rubygems'
require 'mysql2'
require 'logger'
require 'time'
require 'yaml'

# required shared code
require "#{File.dirname(__FILE__)}/shared_code.rb"
#require "./#{File.dirname(__FILE__)}/shared_code.rb"

# some constants and global variables are stored here
RAILS_ENVIRONMENT = "development" # used to open the database
LOG_FILE_PATH = "../../../log/update_tables.log"

# initialise the log
log = Logger.new(File.expand_path(LOG_FILE_PATH, __FILE__))
log.level = Logger::INFO
log.info("****** Starting clean_up.rb ******")

begin
     
rescue Exception => e  
  # on error just log the error message
  log.error(e.message)  
  log.error(e.backtrace.inspect)
end

# Close the database
if db
  db.close 
  log.debug("Database closed")
end

log.info("****** Completed clean_up.rb ******")

##########################################################################################

