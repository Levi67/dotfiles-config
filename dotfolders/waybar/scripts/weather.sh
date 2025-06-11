#!/bin/bash

API_KEY="c915851e412e53f49fb61c6cb79e1e9d"
CITY_ID="2843203"  # You can use city name or coordinates too
UNITS="metric"          # Celsius; use "imperial" for Fahrenheit

# Fetch weather data
weather_json=$(curl -sf "https://api.openweathermap.org/data/2.5/weather?id=$CITY_ID&appid=$API_KEY&units=$UNITS")

if [ -z "$weather_json" ]; then
  echo "Weather N/A"
  exit 1
fi

# Parse temperature and weather main (jq is required)
temp=$(echo "$weather_json" | jq '.main.temp' | xargs printf "%.0f")
condition=$(echo "$weather_json" | jq -r '.weather[0].main')

# Choose icon based on condition
case $condition in
  Clear) icon="☀️";;
  Clouds) icon="☁️";;
  Rain) icon="🌧️";;
  Drizzle) icon="🌦️";;
  Thunderstorm) icon="⛈️";;
  Snow) icon="❄️";;
  Mist|Fog|Haze) icon="🌫️";;
  *) icon="🌡️";;
esac

echo "$icon $temp°C"
