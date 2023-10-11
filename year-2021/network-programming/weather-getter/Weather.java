package org.weather;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.Objects;

public class Weather {
    public static void main(String[] args) throws IOException {
        final String siteURL = "https://weather.com/weather/today/l/ff569b622665789c3567f42200812bc16a7cdb3b088417887e98dd998d9857fe";

        Connection.Response response = Jsoup.connect(siteURL).execute();
        if(response.statusCode() != 200) {
            System.out.println("Status code error!!");
            System.exit(1);
        }
        if(!Objects.requireNonNull(response.contentType()).contains("text/html")) {
            System.out.println("Text is not html!!");
            System.exit(1);
        }
        if(!response.body().contains("Kraków, Lesser Poland Voivodeship, Poland Weather Forecast and Conditions - The Weather Channel | Weather.com")) {
            System.out.println("Header is diff");
            System.exit(1);
        }

        Document page = response.parse();
        Elements currentTemperature = page.select(".CurrentConditions--tempValue--3a50n");
        Elements currentTime = page.select(".CurrentConditions--timestamp--23dfw");
        converter(currentTemperature.text());
        System.out.println(currentTime.text() + " it is: " + converter(currentTemperature.text()) + " in Cracow");
    }

    // For some reason it gives me temperature in Fahrenheits instead of Celsius
    private static String converter(String tempToConvert) {
        StringBuilder sb = new StringBuilder(tempToConvert);
        int tempInFahr = Integer.parseInt(String.valueOf(sb.deleteCharAt(sb.length() - 1)));
        int tempInCelc = (int) ((tempInFahr - 32) / 1.8);
        return tempInCelc + "°";
    }
}
