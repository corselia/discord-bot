require 'discordrb'
require 'rest-client'
require 'json'

def init_bot
  @shiratackey_bot = Discordrb::Commands::CommandBot.new(
    token: ENV['SHIRATACKEY_TOKEN'],
    client_id: ENV['SHIRATACKEY_CLIENT_ID'],
    prefix: ENV['SHIRATACKEY_PREFIX'],
  )
end

def weather_base_data_json(pref_id=130010) # 130010: Tokyo
  JSON.parse(RestClient.get "http://weather.livedoor.com/forecast/webservice/json/v1?city=#{pref_id}")
end

def weather_description(json_data)
  json_data['description']['text']
end

# TODO: ハードコーディング過ぎる
def weather_uri(pinpoint="渋谷区")
  weather_pinpoints = weather_json['pinpointLocations']
  weather_pinpoints.each do |pinpoint|
    @pinpoint_weather_uri = pinpoint['link'] if pinpoint['name'] == pinpoint
  end
  @pinpoint_weather_uri
end

def weather_forecasts_json(json_data)
  json_data['forecasts']
end

def weather_forcasts
  weather_forecasts_json(weather_base_data_json).each do |forecast|
    temperature_min = forecast['temperature']['min'].nil? ? '不明' : "#{forecast['temperature']['min']['celsius']}度"
    temperature_max = forecast['temperature']['max'].nil? ? '不明' : "#{forecast['temperature']['max']['celsius']}度"

    # TODO: ダックタイピングへとリファクタリングする
    if forecast['dateLabel'] == '今日'
      @today_info  = "#{forecast['dateLabel']}（#{forecast['date']}）の#{weather_location_prefecture(weather_base_data_json)}の天気は#{forecast['telop']}です。\n"
      @today_info += "最低気温は#{temperature_min}、最高気温は#{temperature_max}です。\n"
    elsif forecast['dateLabel'] == '明日'
      @tomorrow_info  = "#{forecast['dateLabel']}（#{forecast['date']}）の#{weather_location_prefecture(weather_base_data_json)}の天気は#{forecast['telop']}です。\n"
      @tomorrow_info += "最低気温は#{temperature_min}、最高気温は#{temperature_max}です。\n"
    end
  end
end

def weather_location_city(json_data)
  json_data['location']['city']
end

def weather_location_area(json_data)
  json_data['location']['area']
end

def weather_location_prefecture(json_data)
  json_data['location']['prefecture']
end

def bot_command
  @shiratackey_bot.command :greet do |event|
    # event.send_message("ちーっす、@#{event.user.id}")
    event.send_message("ちーっす、#{event.user.mention} ")
  end

  @shiratackey_bot.command :weather do |event|
    event.send_message("#{weather_description(weather_base_data_json)}")
  end

  @shiratackey_bot.command :weather_today do |event|
    event.send_message("#{@today_info}")
  end

  @shiratackey_bot.command :weather_tomorrow do |event|
    event.send_message("#{@tomorrow_info}")
  end
end

# TODO: クラス化
init_bot
weather_forcasts # @today_info と @tomorrow_info が定義される
bot_command

@shiratackey_bot.run
