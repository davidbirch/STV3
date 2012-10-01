################################################################################
def CheckBlackChannel(db,log,row)
  # returns true/false
  # this check is for black channels
  
  # use a default return value
  return_value = false
  
  querystring = "
  SELECT channel_xmltv_id
  FROM rules
  WHERE rule_type = 'Black Channel'"
  
  log.debug("Run database query: #{querystring}")
  black_channel_list = db.query(querystring)
  
  if black_channel_list.count == 0
    # no black channel rules so return false
    # do nothing
   
  else
    # loop through each black channel and return true if there is a match
    black_channel_list.each do |black_channel|
      if black_channel["channel_xmltv_id"] == row["channel_xmltv_id"]
        # set the return value to true
        return_value = true
        #log.debug("XXX - Black Channel match found(#{black_channel["channel_xmltv_id"]})")
      else
        #do nothing
      end
    end
  end
  
  # return the appropriate value
  return return_value

end
################################################################################
def CheckBlackKeyword(db,log,row)
  # returns true/false
  # this check is for black keywords
  
  # use a default return value
  return_value = false
  
  querystring = "
  SELECT value
  FROM rules
  WHERE rule_type = 'Black Keyword'"
  
  log.debug("Run database query: #{querystring}")
  black_keyword_list = db.query(querystring)
  
  if black_keyword_list.count == 0
    # no black keyword rules so return false
    # do nothing
   
  else
    # loop through each black keyword and return true if there is a match
    program_title = row["title"].downcase
    program_subtitle = row["subtitle"].downcase
    #program_description = row["description"].downcase
    program_category = row["category"].downcase
    
    black_keyword_list.each do |black_keyword|
      
      # get the keyword value
      black_keyword_value = black_keyword["value"].downcase
      
      if program_title.include? black_keyword_value
        # set the return value to true
        return_value = true
        #log.debug("XXX - Black Keyword match found (#{black_keyword_value})")
      elsif program_subtitle.include? black_keyword_value  
        # set the return value to true
        return_value = true
        #log.debug("XXX - Black Keyword match found (#{black_keyword_value})")
      #elsif program_description.include? black_keyword_value  
      #  # set the return value to true
      #  return_value = true
      #  #log.debug("XXX - Black Keyword match found (#{black_keyword_value})")
      elsif program_category.include? black_keyword_value  
        # set the return value to true
        return_value = true
        #log.debug("XXX - Black Keyword match found (#{black_keyword_value})")
      else
        #do nothing
      end
    end
  end
  
  # return the appropriate value
  return return_value

end
################################################################################
def CheckWhiteKeyword(db,log,row)
  # returns keyword or blank
  # this check is for white keywords
  
  # use a default return value
  return_value = ""
  
  querystring = "
  SELECT value, sport_name
  FROM rules
  WHERE rule_type = 'White Keyword'
  ORDER BY priority DESC, LENGTH(value) DESC"
  
  log.debug("Run database query: #{querystring}")
  white_keyword_list = db.query(querystring)
  
  if white_keyword_list.count == 0
    # no white keyword rules so return ""
    # do nothing
   
  else
    # loop through each black keyword and return true if there is a match
    program_title = row["title"].downcase
    program_subtitle = row["subtitle"].downcase
    #program_description = row["description"].downcase
    program_category = row["category"].downcase
    
    # log for performance monitoring
    #log.debug("Start Keyword Search for: #{program_title}")
    
    white_keyword_list.each do |white_keyword|
      
      # ****************************************************
      # * this is a slightly complicated block of code but *
      # * it is trying to optimise the way multiple word   *
      # * searches and single word searches are executed   *
      # ****************************************************
            
      # get the keyword value
      white_keyword_value = white_keyword["value"].downcase
      white_keyword_sport_name = white_keyword["sport_name"]
      if return_value != ""
        #stop looping once a keyword is found
        break
      elsif white_keyword_value.include? " "
        # the keyword contains a space so it has multiple words
        # in this case do a standard include search
        if program_title.include? white_keyword_value
          # match so return the sport name
          return_value = white_keyword_sport_name
        elsif program_subtitle.include? white_keyword_value
          # match so return the sport name
          return_value = white_keyword_sport_name
        elsif program_category.include? white_keyword_value
          # match so return the sport name
          return_value = white_keyword_sport_name
        else
          # no matches so do nothing
        end
      else
        # the keyword contains no space so it has only one words
        # in this case do a standard include search
        if return_value == ""
          program_title.split.each do |s|
            if s == white_keyword_value
              # match so return the sport name
              return_value = white_keyword_sport_name
            end
          end
        end
        # check for a return value again in case a match has already been found
        if return_value == ""
          program_subtitle.split.each do |s|
            if s == white_keyword_value
              # match so return the sport name
              return_value = white_keyword_sport_name
            end
          end
        end
        # check for a return value again in case a match has already been found
        if return_value == ""
          program_category.split.each do |s|
            if s == white_keyword_value
              # match so return the sport name
              return_value = white_keyword_sport_name
            end
          end
        end
      end
    end
  end
  
  # log for performance monitoring
  #log.debug("Return Value is: #{return_value}")
  #log.debug("Complete Keyword Search for: #{program_title}")
  
  # return the appropriate value
  return return_value


end
################################################################################
def CheckSportLiteral(db,log,row)
  # returns true/false
  # this check is for a generic 'sport' match
  
  # use a default return value
  return_value = false
  
  # loop through each black keyword and return true if there is a match
  program_title = row["title"].downcase
  program_subtitle = row["subtitle"].downcase
  #program_description = row["description"].downcase
  program_category = row["category"].downcase
    
  if program_title.include? "sport"
    # set the return value to true
    return_value = true
    #log.debug("XXX - Sport literal match found")
  elsif program_subtitle.include? "sport"
    # set the return value to true
    return_value = true
    #log.debug("XXX - Sport literal match found")
  #elsif program_description.include? "sport"
  #  # set the return value to true
  #  return_value = true
  #  #log.debug("XXX - Sport literal match found")
  elsif program_category.include? "sport"  
    # set the return value to true
    return_value = true
    #log.debug("XXX - Sport literal match found")
  else
    #do nothing
  end
 
  # return the appropriate value
  return return_value

end
################################################################################
def CheckNewsOrWeather(db,log,row)
  # returns true/false
  # this check is for a generic 'news' or 'weather' match
  
  # use a default return value
  return_value = false
  
  # loop through and return true if there is a match
  program_title = row["title"].downcase
  program_subtitle = row["subtitle"].downcase
  #program_description = row["description"].downcase
  program_category = row["category"].downcase
    
  if program_title.include? "weather"
    # set the return value to true
    return_value = true
    #log.debug("XXX - Sport/Weather literal match found")
  elsif program_subtitle.include? "weather"
    # set the return value to true
    return_value = true
    #log.debug("XXX - Sport/Weather literal match found")
  #elsif program_description.include? "weather"
  #  # set the return value to true
  #  return_value = true
  #  #log.debug("XXX - Sport/Weather literal match found")
  elsif program_category.include? "weather"  
    # set the return value to true
    return_value = true
    #log.debug("XXX - Sport/Weather literal match found")
  elsif program_title.include? "news"
    # set the return value to true
    return_value = true
    #log.debug("XXX - Sport/News literal match found")
  elsif program_subtitle.include? "news"
    # set the return value to true
    return_value = true
    #log.debug("XXX -Sport/News literal match found")
  #elsif program_description.include? "news"
  #  # set the return value to true
  #  return_value = true
  #  #log.debug("XXX - Sport/News literal match found")
  elsif program_category.include? "news"  
    # set the return value to true
    return_value = true
    #log.debug("XXX - Sport/News literal match found")      
  else
    #do nothing
  end
 
  # return the appropriate value
  return return_value

end
################################################################################

def GetSport(db,log,row)
  # this function returns the sport based on the magic algorithm
  # inputs are
  # - the databse
  # - the log file
  # - the row which was returned from raw_programs
  
  # returns a string either
  # 1) A sport name - Cricket, AFL, Golf, etc...
  # 2) A blank value - designating the record as not having relevance

  begin
  
    if CheckBlackChannel(db,log,row)
      # check 1 - black channels
      # True means this is a black channel so return blank
      return ""

    elsif CheckBlackKeyword(db,log,row)
      # check 2 - black keywords
      # True means there is a black keyword so return blank
      return ""
   
    else

      sportname = CheckWhiteKeyword(db,log,row)
      if sportname != "" 
        # a sportname was returned by CheckWhiteKeyword
        return sportname
        
      elsif CheckSportLiteral(db,log,row)
        # a special rule for anything with 'sport' as a keyword
        # include it as 'Other Sports' unless it is flagged as news or weather
        if CheckNewsOrWeather(db,log,row)
          # this is a record with a match on 'sport' that is also 'news' or 'weather'
          return ""
          
        else
          # this is a record with a match on 'sport' that is not 'news' or 'weather'
          return "Other Sport"
          
        end
      else
        # this will be all non-sports
        return ""
        
      end
    end
      
  rescue Exception => e  
    # on error just log the error message
    log.error(e.message)  
    log.error(e.backtrace.inspect)
    
    # in case of an error return an empty result - the record will be disregarded
    return ""
  end
end
################################################################################
