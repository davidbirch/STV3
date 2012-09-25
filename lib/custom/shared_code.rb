################################################################################
def CheckBlackChannel(db,log,row)
  # returns true/false
  # this check is for black channels
  
  # for now just return false
  return false

end
################################################################################
def CheckBlackKeyword(db,log,row)
  # returns true/false
  # this check is for black keywords
  
  # for now just return false
  return false

end
################################################################################
def CheckWhiteKeyword(db,log,row)
  # returns keyword or blank
  # this check is for white keywords
  
  # for now return a default - Cricket
  return "Cricket"

end
################################################################################
def CheckSportLiteral(db,log,row)
  # returns true/false
  # this check is for a generic 'sport' match
  
  # for now return false
  return false

end
################################################################################
def CheckNewsOrWeather(db,log,row)
  # returns true/false
  # this check is for a generic 'news' or 'weather' match
  
  # for now return false
  return false

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
