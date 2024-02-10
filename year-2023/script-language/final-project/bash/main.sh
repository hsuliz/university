#!/bin/bash

# Initialize default values
declare -A WEATHER_INFO
CITY=""
VERBOSITY_LEVEL=1
SAVE_TO_FILE=false

# Help function
print_help() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  --help, --h             Show this help message."
    echo "  --city CITY             Specify a city for weather information."
    echo "  --v, --vv, --vvv        Specify verbosity level for more detailed weather information."
    echo "  --file                  Save the weather report to a file in JSON format."
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --city) CITY="$2"; shift ;;
        --file) SAVE_TO_FILE=true ;;
        --v) VERBOSITY_LEVEL=1 ;;
        --vv) VERBOSITY_LEVEL=2 ;;
        --vvv) VERBOSITY_LEVEL=3 ;;
        --h|--help) print_help; exit 0 ;;
        *) echo "Unknown option: $1"; print_help; exit 1 ;;
    esac
    shift
done

fetch_weather_data() {
    local unit_param="m"

    if [ -n "$CITY" ]; then
        URL="https://wttr.in/${CITY}?format=j1&u=${unit_param}"
    else
        URL="https://wttr.in/?format=j1&u=${unit_param}"
    fi
    WEATHER_DATA=$(curl -s "$URL")
}


populate_weather_info() {
    WEATHER_INFO[timestamp]=$(jq -r ".current_condition[0].localObsDateTime" <<< "$WEATHER_DATA")
    WEATHER_INFO[country]=$(jq -r ".nearest_area[0].country[0].value" <<< "$WEATHER_DATA")
    WEATHER_INFO[city]=$(jq -r ".nearest_area[0].areaName[0].value" <<< "$WEATHER_DATA")
    WEATHER_INFO[temp_C]=$(jq -r ".current_condition[0].temp_C" <<< "$WEATHER_DATA")
    WEATHER_INFO[FeelsLikeC]=$(jq -r ".current_condition[0].FeelsLikeC" <<< "$WEATHER_DATA")
    WEATHER_INFO[weatherDesc]=$(jq -r ".current_condition[0].weatherDesc[0].value" <<< "$WEATHER_DATA")
    WEATHER_INFO[windspeedKmph]=$(jq -r ".current_condition[0].windspeedKmph" <<< "$WEATHER_DATA")
    WEATHER_INFO[humidity]=$(jq -r ".current_condition[0].humidity" <<< "$WEATHER_DATA")
    WEATHER_INFO[precipMM]=$(jq -r ".current_condition[0].precipMM" <<< "$WEATHER_DATA")
    WEATHER_INFO[visibility]=$(jq -r ".current_condition[0].visibility" <<< "$WEATHER_DATA")
    WEATHER_INFO[pressure]=$(jq -r ".current_condition[0].pressure" <<< "$WEATHER_DATA")

    if [ "$VERBOSITY_LEVEL" -eq 2 ]; then
        WEATHER_INFO[sunrise]=$(jq -r ".weather[0].astronomy[0].sunrise" <<< "$WEATHER_DATA")
        WEATHER_INFO[sunset]=$(jq -r ".weather[0].astronomy[0].sunset" <<< "$WEATHER_DATA")
        WEATHER_INFO[chanceOfRain]="$(jq -r '.weather[0].hourly[0].chanceofrain' <<< "$WEATHER_DATA")"
        WEATHER_INFO[moonrise]=$(jq -r ".weather[0].astronomy[0].moonrise" <<< "$WEATHER_DATA")
        WEATHER_INFO[moonset]=$(jq -r ".weather[0].astronomy[0].moonset" <<< "$WEATHER_DATA")
        WEATHER_INFO[maxtempC]=$(jq -r ".weather[0].maxtempC" <<< "$WEATHER_DATA")
        WEATHER_INFO[mintempC]=$(jq -r ".weather[0].mintempC" <<< "$WEATHER_DATA")
    fi

    if [ "$VERBOSITY_LEVEL" -eq 3 ]; then
      WEATHER_INFO[uvIndex]=$(jq -r ".weather[0].uvIndex" <<< "$WEATHER_DATA")
      WEATHER_INFO[cloudcover]=$(jq -r ".current_condition[0].cloudcover" <<< "$WEATHER_DATA")
      WEATHER_INFO[winddirDegree]=$(jq -r ".current_condition[0].winddirDegree" <<< "$WEATHER_DATA")
      WEATHER_INFO[winddir16Point]=$(jq -r ".current_condition[0].winddir16Point" <<< "$WEATHER_DATA")
      WEATHER_INFO[weatherDescTomorrow]=$(jq -r ".weather[1].hourly[0].weatherDesc[0].value" <<< "$WEATHER_DATA")
      WEATHER_INFO[maxtempCTomorrow]=$(jq -r ".weather[1].maxtempC" <<< "$WEATHER_DATA")
      WEATHER_INFO[mintempCTomorrow]=$(jq -r ".weather[1].mintempC" <<< "$WEATHER_DATA")
    fi
}

print_weather() {
    echo "Local observation date: ${WEATHER_INFO[timestamp]}"
    echo "Country: ${WEATHER_INFO[country]}"
    echo "City: ${WEATHER_INFO[city]}"
    echo "Temperature: ${WEATHER_INFO[temp_C]}°C"
    echo "Feels Like: ${WEATHER_INFO[FeelsLikeC]}°C"
    echo "Weather Description: ${WEATHER_INFO[weatherDesc]}"
    echo "Chance of rain: ${WEATHER_INFO[chanceOfRain]}%"
    echo "Wind Speed: ${WEATHER_INFO[windspeedKmph]} km/h"
    echo "Humidity: ${WEATHER_INFO[humidity]}%"
    echo "Precipitation: ${WEATHER_INFO[precipMM]} mm"
    echo "Visibility: ${WEATHER_INFO[visibility]} km"
    echo "Pressure: ${WEATHER_INFO[pressure]} hPa"

    if [ "$VERBOSITY_LEVEL" -eq 2 ]; then
        echo "Sunrise: ${WEATHER_INFO[sunrise]}"
        echo "Sunset: ${WEATHER_INFO[sunset]}"
        echo "Moonrise: ${WEATHER_INFO[moonrise]}"
        echo "Moonset: ${WEATHER_INFO[moonset]}"
        echo "Max Temperature Today: ${WEATHER_INFO[maxtempC]}°C"
        echo "Min Temperature Today: ${WEATHER_INFO[mintempC]}°C"
    fi

    if [ "$VERBOSITY_LEVEL" -eq 3 ]; then
        echo "UV Index: ${WEATHER_INFO[uvIndex]}"
        echo "Cloud Cover: ${WEATHER_INFO[cloudcover]}%"
        echo "Wind Direction: ${WEATHER_INFO[winddirDegree]} degrees (${WEATHER_INFO[winddir16Point]})"
        echo "Weather Description Tomorrow: ${WEATHER_INFO[weatherDescTomorrow]}"
        echo "Max Temperature Tomorrow: ${WEATHER_INFO[maxtempCTomorrow]}°C"
        echo "Min Temperature Tomorrow: ${WEATHER_INFO[mintempCTomorrow]}°C"
    fi
}

process_weather_data() {
    fetch_weather_data
    populate_weather_info

    if [ "$SAVE_TO_FILE" = true ]; then
        DATE=$(date "+%Y-%m-%d")
        FILENAME="weather_report_${WEATHER_INFO[city]:-"unknown"}_${DATE}.txt"
        print_weather > "$FILENAME"
        echo "Weather report saved to $FILENAME"
    else
        print_weather
    fi
}

main() {
    process_weather_data
}

main