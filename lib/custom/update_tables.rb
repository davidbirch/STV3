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

# required shared code
require "./#{File.dirname(__FILE__)}/shared_code.rb"

# some constants and global variables are stored here
RAILS_ENVIRONMENT = "development" # used to open the database
LOG_FILE_PATH = "../../../log/update_tables.log"

# initialise the log
log = Logger.new(File.expand_path(LOG_FILE_PATH, __FILE__))
log.level = Logger::INFO
log.info("****** Starting update_tables.rb ******")

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
   
  querystring ="
  SELECT *
  FROM raw_channels"
  log.debug("Run database query: #{querystring}")
  
  # execute the database query
  results = db.query(querystring)
  log.info("Number of rows in raw_channels: #{results.count}")
  
  #loop through each channel
  results.each do |row|
    
    # check if the channel already exists
    channel_xmltv_id = row["xmltv_id"]
    querystring = "
    SELECT id
    FROM channels
    WHERE xmltv_id = '#{channel_xmltv_id}'"
    
    # execute the database query
    log.debug("Run database query: #{querystring}")
    channel_check = db.query(querystring)
    
    if channel_check.count > 0
      # match so do not create a record 
   
    else
      # the record does not exist so create it
      channel_created_at = Time.now # note: this is the Rails created_at, not a Channel attribute
      channel_updated_at = channel_created_at # note: this is the Rails updated_at, not a Channel attribute
      
      # create the computed values
      channel_name = db.escape(row["channel_name"])
      channel_short_name = channel_name[0,4] #get the first four characters as default for the short name
      if channel_xmltv_id.include? "free"
        channel_free_or_pay = "free"
      else
        channel_free_or_pay = "pay"
      end
        
      # create the channel record  
      querystring = "
      INSERT INTO channels (xmltv_id, channel_name, channel_short_name, channel_free_or_pay, created_at, updated_at)
      VALUES('#{channel_xmltv_id}', '#{channel_name}', '#{channel_short_name}',  '#{channel_free_or_pay}', '#{channel_created_at}', '#{channel_updated_at}')"
  
      # execute the database query to create the user
      log.debug("Run database query: #{querystring}")
      db.query(querystring)
     
    end
    
    # now delete the channel and any others from the raw_channels table
    querystring = "
    DELETE FROM raw_channels
    WHERE xmltv_id = '#{channel_xmltv_id}'"
      
    # execute the  query
    log.debug("Run database query: #{querystring}")
    db.query(querystring)
   
  end
  
  querystring ="
  SELECT *
  FROM raw_programs"
  log.debug("Run database query: #{querystring}")
  
  # execute the database query
  results = db.query(querystring)
  log.info("Number of rows in raw_programs: #{results.count}")
  
  #loop through each program
  results.each do |row|
  
    # get the relevant program attributes from the raw_program object
    program_title = db.escape(row["title"])
    program_subtitle = db.escape(row["subtitle"])
    program_category = db.escape(row["category"])
    program_description = db.escape(row["description"])
    program_start_datetime = row["start_datetime"]
    program_end_datetime = row["end_datetime"]
    program_region_name =  row["region_name"]
    program_channel_xmltv_id =  row["channel_xmltv_id"]
       
    # set the created and updated dates 
    program_created_at = Time.now # note: this is the Rails created_at, not a Program attribute
    program_updated_at = program_created_at # note: this is the Rails updated_at, not a Program attribute
      
    # calculate the channel_id
    querystring = "
    SELECT id
    FROM channels
    WHERE xmltv_id = '#{program_channel_xmltv_id}'"
        
    # get the channel_id
    # this cycles through in case there are multiple records
    log.debug("Run database query: #{querystring}")
    channel_check = db.query(querystring)
    channel_id = 0
    channel_check.each do |channel|
      channel_id = channel["id"]
    end
    
    # calculate the region_id
    querystring = "
    SELECT id
    FROM regions
    WHERE region_name = '#{program_region_name}'"
        
    # get the region_id
    # this cycles through in case there are multiple records
    log.debug("Run database query: #{querystring}")
    region_check = db.query(querystring)
    region_id = 0
    region_check.each do |region|
      region_id = region["id"]
    end
    
    # filter the sport using the GetSport algorithm
    program_sport_name = GetSport(db,log,row)
     
    if program_sport_name == ""
      # the sport was not a match so do nothing
      # the entry will be deleted outside the if statement
      
    else
      # calculate the sport_id
      querystring = "
      SELECT id
      FROM sports
      WHERE sport_name = '#{program_sport_name}'"
        
      # get the sport_id
      # this cycles through in case there are multiple records
      log.debug("Run database query: #{querystring}")
      sport_check = db.query(querystring)
      sport_id = 0
      sport_check.each do |sport|
        sport_id = sport["id"]
      end
      
      # all relevant information exists and the sport has been categorised
      # create the program record
      querystring = "
      INSERT INTO programs (title, subtitle, category, description, start_datetime, end_datetime, region_name, region_id, sport_name, sport_id, channel_xmltv_id, channel_id, created_at, updated_at)
      VALUES('#{program_title}', '#{program_subtitle}', '#{program_category}',  '#{program_description}', '#{program_start_datetime}', '#{program_end_datetime}', '#{program_region_name}', '#{region_id}', '#{program_sport_name}', '#{sport_id}', '#{program_channel_xmltv_id}', '#{channel_id}', '#{program_created_at}', '#{program_updated_at}')"
  
      # execute the database query to create the user
      log.debug("Run database query: #{querystring}")
      db.query(querystring)
     
    end
    
    # now delete the program from the raw_programs table
    querystring = "
    DELETE FROM raw_programs
    WHERE id = '#{row["id"]}'"
      
    # execute the  query
    log.debug("Run database query: #{querystring}")
    db.query(querystring)
  
  end
    
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

log.info("****** Completed update_tables.rb ******")

##########################################################################################