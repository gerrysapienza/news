require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Evanston, Kellogg Global Hub
  lat = 42.0574063
  long = -87.6722787

  units = "imperial"
  key = "176a0f1861b4998a0338a65a99f2e2ca" 

  # URL for the WX Call
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{key}"

  # API Call
  @forecast = HTTParty.get(url).parsed_response.to_hash

  # time and date stuff
  @time1 = Time.new.strftime("%M")
  @time = Time.new
  @day_name = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
  month_name= ["Null","January","February","March","April","May","June","July","August","September","October","November","December"]
  
  @day_number = @time.wday
  @dailyname = @day_name[@time.wday]
  if @time.hour < 5
    @dayname = @day_name[@time.wday - 1]
  else
    @dayname = @day_name[@time.wday]
  end

  @minutes = @time1
  
  @month= month_name[@time.month]
  @date = @time.day
  @year = @time.year
  if @time.hour < 5
    @hour = @time.hour + 19
  else
    @hour = @time.hour - 5
  end
  

  #puts "It is currently #{@forecast["current"]["temp"]} degrees"

  #"It is currently #{@forecast["current"]["temp"]} degrees (feels like #{@forecast["current"]["feels_like"]} degrees) with #{@forecast["current"]["weather"][0]["description"]}"
  #"7 Day Forecast:"
    @day_number = 1
    
    for day in @forecast["daily"]
        "On day #{@day_number}, A high of #{day["temp"]["max"]} and #{day["weather"][0]["description"]}"
        
    end
    
  ### Get the news

  news_key = "d3170819a0944a828018f07b23ec373c"
  url_news = "https://newsapi.org/v2/top-headlines?country=us&apiKey=#{news_key}"
  @news = HTTParty.get(url_news).parsed_response.to_hash

  #pp @news

 # puts "each article title"
  #for articles in @news["articles"]
    #@title[] = articles["title"]
  #end

  #puts @title

  view 'news'
end
