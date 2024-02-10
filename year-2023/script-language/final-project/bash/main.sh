#!/bin/bash
# Hlib-Oleksandr Suliz, Script Language, group no.2

declare -A WEATHER_INFO
CITY=""
VERBOSITY_LEVEL=1
SAVE_TO_FILE=false
CONFIG_FILE=".config"
SET_DEFAULT_CITY=""
RESET_DEFAULT_CITY=false
OPERATION_COUNT=0

if [ ! -f "$CONFIG_FILE" ]; then
    echo "DEFAULT_CITY=0" > "$CONFIG_FILE"
else
    source "$CONFIG_FILE"
fi

# Help function
print_help() {
    echo "Weather Report Script Usage Guide"
    echo "=================================="
    echo "This script fetches and displays weather information for a specified city or the default city set in the configuration."
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --help, --h"
    echo "      Show this help message."
    echo ""
    echo "  --city CITY"
    echo "      Specify a city for weather information. This option overrides the default city set in the configuration file."
    echo ""
    echo "  --v, --vv, --vvv"
    echo "      Specify verbosity level for more detailed weather information."
    echo "      --v    : Basic weather information."
    echo "      --vv   : Includes additional details like sunrise, sunset, and chances of rain."
    echo "      --vvv  : Includes comprehensive details including UV index, cloud cover, and weather forecast for tomorrow."
    echo ""
    echo "  --file"
    echo "      Save the weather report to a file. The file is named 'weather_report_CITY_DATE.txt', where CITY is the specified or default city, and DATE is the current date."
    echo ""
    echo "  --set-default-city CITY"
    echo "      Set a new default city in the configuration file. This option cannot be used with other options."
    echo "      Example: $0 --set-default-city \"Kyiv\""
    echo ""
    echo "  --reset"
    echo "      Reset the default city to '0' (no default city). This option cannot be used with other options."
    echo ""
    echo "Examples:"
    echo "  $0 --city \"Los Angeles\" --vv"
    echo "      Fetches detailed weather information for Los Angeles."
    echo ""
    echo "  $0 --set-default-city \"Cracow\""
    echo "      Sets Cracow as the default city for future queries."
    echo ""
    echo "  $0 --reset"
    echo "      Resets the default city to no specific city."
    echo ""
    echo "Note: To fetch weather information, the script uses the wttr.in service. Ensure you have internet connectivity."
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --city) CITY="$2"; shift; ((OPERATION_COUNT++)) ;;
        --file) SAVE_TO_FILE=true; ((OPERATION_COUNT++)) ;;
        --v) VERBOSITY_LEVEL=1; ((OPERATION_COUNT++)) ;;
        --vv) VERBOSITY_LEVEL=2; ((OPERATION_COUNT++)) ;;
        --vvv) VERBOSITY_LEVEL=3; ((OPERATION_COUNT++)) ;;
        --set-default-city) SET_DEFAULT_CITY="$2"; shift ;;
        --reset) RESET_DEFAULT_CITY=true ;;
        --h|--help) print_help; exit 0 ;;
        *) echo "Unknown option: $1"; print_help; exit 1 ;;
    esac
    shift
done

if [ "$RESET_DEFAULT_CITY" = true ] || [ -n "$SET_DEFAULT_CITY" ]; then
    if [ "$OPERATION_COUNT" -ne 0 ] || ([ "$RESET_DEFAULT_CITY" = true ] && [ -n "$SET_DEFAULT_CITY" ]); then
        echo "Error: --reset and --set-default-city cannot be used with other options or each other."
        print_help
        exit 1
    elif [ "$RESET_DEFAULT_CITY" = true ]; then
        echo "Resetting default city to '0'"
        echo "DEFAULT_CITY=0" > "$CONFIG_FILE"
        echo "Default city reset in configuration file."
        exit 0
    else
        echo "Setting new default city to '$SET_DEFAULT_CITY'"
        echo "DEFAULT_CITY=$SET_DEFAULT_CITY" > "$CONFIG_FILE"
        echo "Default city updated in configuration file."
        exit 0
    fi
fi

if [ -z "$CITY" ] && [ "$DEFAULT_CITY" != "0" ]; then
    CITY=$DEFAULT_CITY
fi

fetch_weather_data() {
    local UNIT_PARAM="m"
    local STATUS_Code
    local CURL_OUTPUT
    local CURL_FILENAME="/tmp/curl_error_$$"

    if [ -n "$CITY" ]; then
        URL="https://wttr.in/${CITY}?format=j1&u=${UNIT_PARAM}"
    else
        URL="https://wttr.in/?format=j1&u=${UNIT_PARAM}"
    fi

    CURL_OUTPUT=$(curl -s -w "%{http_code}" --connect-timeout 8 --max-time 8 -o - "$URL" --stderr "$CURL_FILENAME")
    STATUS_Code=$(echo "$CURL_OUTPUT" | tail -n1)
    WEATHER_DATA=$(echo "$CURL_OUTPUT" | head -n -1)

    if [ -n "$CURL_FILENAME" ] && [ -s "$CURL_FILENAME" ]; then
        echo "Error fetching weather data: $(<"$CURL_FILENAME")"
        rm "$CURL_FILENAME"
        exit 1
    fi

    if [ "$STATUS_Code" -ne 200 ]; then
        echo "Error: Failed to fetch weather data. HTTP Status Code: $STATUS_Code"
        rm "$CURL_FILENAME" 2>/dev/null
        exit 1
    fi

    if ! jq empty <<< "$WEATHER_DATA" 2>/dev/null; then
        echo "Error: Invalid JSON content received."
        exit 1
    fi

    rm "$CURL_FILENAME" 2>/dev/null
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
    local MAX_RETRIES=3
    local DELAY=5
    local TRY_COUNT=0

    while : ; do
        fetch_weather_data
        if [ $? -eq 0 ]; then
            populate_weather_info
            break
        else
            ((TRY_COUNT++))
            echo "Attempt $TRY_COUNT failed. Retrying in $DELAY seconds..."
            if [ "$TRY_COUNT" -ge "$MAX_RETRIES" ]; then
                echo "Failed to fetch weather data after $MAX_RETRIES attempts."
                exit 1
            fi
            sleep "$DELAY"
        fi
    done

    if [ "$SAVE_TO_FILE" = true ]; then
        DATE=$(date "+%Y-%m-%d")
        FILENAME="weather_report_${WEATHER_INFO[city]:-"unknown"}_${DATE}.txt"
        print_weather > "$FILENAME"
        echo "Weather report saved to $FILENAME"
    else
        print_weather
    fi
}


check_internet_connection() {
    if ! ping -c 1 google.com > /dev/null 2>&1; then
        echo "Error: No internet connection. Please check your internet connection and try again."
        exit 1
    fi
}

main() {
    check_internet_connection
    process_weather_data
}

main
