# ************************************************************************
# ** script to update the program and channel tables including the      **
# ** categorisation by sport                                            **
# ** created DB 23/09                                                   **
# ************************************************************************

# required libraries
require 'rubygems'
require 'mysql2'
require 'logger'
require 'time'
require 'yaml'

# some constants and global variables are stored here
RAILS_ENVIRONMENT = "development" # used to open the database
LOG_FILE_PATH = "../../../log/update_tables.log"

# initialise the log
log = Logger.new(File.expand_path(LOG_FILE_PATH, __FILE__))
log.info("Starting update_tables.rb")


begin
    
  # access the database
  db_yaml = YAML.load_file(File.expand_path("../../../config/database.yml", __FILE__))
  db_config = db_yaml[RAILS_ENVIRONMENT]
  
  # Initialise the database
  db = Mysql2::Client.new(
    :host => "localhost",
    :username => db_config["username"],
    :password => db_config["password"],
    :database => db_config["database"]
  )
  log.info("update_tables.rb is connected to the database - Server Info: #{db.server_info}")
  
  # log the row count for 'raw_channels'
  results = db.query("SELECT id FROM raw_channels")
  log.info("Number of rows in raw_channels: #{results.count}")
    
  # log the row count for 'raw_programs'
  results = db.query("SELECT id FROM raw_programs")
  log.info("Number of rows in raw_programs: #{results.count}")
  
  end
    
rescue Exception => e  
  # on error just log the error message
  log.error(e.message)  
  log.error(e.backtrace.inspect)
end

# Close the database
if db
  db.close 
  log.info("Database closed")
end
##########################################################################################