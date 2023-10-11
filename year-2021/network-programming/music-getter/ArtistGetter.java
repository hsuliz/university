package org.example;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;

public class ArtistGetter {
    public static void main(String[] args) {

        String userCode;
        Scanner scanner = new Scanner(System.in);
        while (true) {
            System.out.println("Please, type ID of your band (like 3898, 6516 or 200115). For exit, enter 0.");
            MusicGetter musicGetter = new MusicGetter();
            userCode = scanner.next();
            if (Integer.parseInt(userCode) == 0) {
                System.out.println("Bye!!");
                break;
            }
            musicGetter.getSameIndividuals(Integer.parseInt(userCode));
            System.out.println();
        }

        // TestCases
        // musicGetter.getSameIndividuals(3898);
        // musicGetter.getSameIndividuals(359282);
        // musicGetter.getSameIndividuals(6501645);
        // musicGetter.getSameIndividuals(10783);
        // musicGetter.getSameIndividuals(17199);
        // musicGetter.getSameIndividuals(6516);
    }
}

class MusicGetter {
    // take each member as artist and check
    List<Integer> idList;
    String bandName;

    public void getSameIndividuals(int id) {
        try {
            getRequestForBand(id);
            getSameArtists();
        } catch (Exception exception) {
            throw new RuntimeException("error!");
        }
    }

    private void getRequestForBand(int id) throws IOException {

        String urlString = "https://api.discogs.com/artists/" + id;
        URL url = new URL(urlString);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        // check code resp
        String read;
        int responseCode = conn.getResponseCode();

        if (responseCode == HttpURLConnection.HTTP_OK) {
            InputStreamReader inputStreamReader = new InputStreamReader(conn.getInputStream());
            BufferedReader bf = new BufferedReader(inputStreamReader);
            StringBuilder stringBuilder = new StringBuilder();
            while ((read = bf.readLine()) != null) {
                stringBuilder.append(read);
            }
            bf.close();
            conn.disconnect();
            ///
            idList = new ArrayList<>();
            String jsonString = stringBuilder.toString();
            JSONObject obj = new JSONObject(jsonString);
            bandName = obj.getString("name");
            JSONArray jsonArray = obj.getJSONArray("members");
            for (int i = 1; i < jsonArray.length(); i++) {
                //System.out.println(jsonArray.getJSONObject(i).get("id"));
                //System.out.println(jsonArray.getJSONObject(i).getString("name"));
                idList.add((Integer) jsonArray.getJSONObject(i).get("id"));
            }
        } else if (responseCode == 429) {
            System.out.println("Response code " + responseCode + ": Too many requests!!");
        } else {
            System.out.println(responseCode);
            System.out.println(responseCode + "Doesnt work");
        }
        ////
    }

    private void getSameArtists() throws IOException {
        // tree map for sorting
        Map<String, TreeSet<String>> stringMap = new TreeMap<>();
        for (Integer integer : idList) {

            String urlString = "https://api.discogs.com/artists/" + integer;
            URL url = new URL(urlString);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            String read;
            int responseCode = conn.getResponseCode();

            if (responseCode == HttpURLConnection.HTTP_OK) {
                //System.out.println(responseCode);
                InputStreamReader inputStreamReader = new InputStreamReader(conn.getInputStream());
                BufferedReader bf = new BufferedReader(inputStreamReader);
                StringBuilder stringBuilder = new StringBuilder();
                while ((read = bf.readLine()) != null) {
                    stringBuilder.append(read);
                }
                bf.close();
                conn.disconnect();
                ///////////////////
                String jsonString = stringBuilder.toString();
                JSONObject jsonObject = new JSONObject(jsonString);
                JSONArray jsonArray = jsonObject.getJSONArray("groups");
                String currentNameArtist = jsonObject.getString("name");

                for (int j = 0; j < jsonArray.length(); j++) {
                    String bandName = String.valueOf(jsonArray.getJSONObject(j).getString("name"));
                    //System.out.println(jsonArray.getJSONObject(j));
                    // anti null system
                    Set<String> tmp = new TreeSet<>();
                    tmp.add(currentNameArtist);
                    if (stringMap.get(bandName) == null) {
                        stringMap.put(bandName, new TreeSet<>(tmp));
                        continue;
                    }
                    tmp.addAll(stringMap.get(bandName));
                    stringMap.put(bandName, (TreeSet<String>) tmp);
                }
            } else if (responseCode == 429) {
                System.out.println();
                throw new IllegalAccessError("Response code " + responseCode + ": Too many requests!! Wait a minute!!");
            } else {
                throw new RuntimeException("Response code " + responseCode + ": Probably something bad happened");
            }
        }

        ////sorting
        stringMap.remove(bandName);
        List<String> keys = new ArrayList<>(stringMap.keySet());
        System.out.println("Your band name is: " + bandName);
        int noneCounter = -1;
        for (int i = 0; i < stringMap.size(); i++) {
            if (stringMap.get(keys.get(i)).size() == 1) {
                continue;
            }
            System.out.println(keys.get(i) + ": " + stringMap.get(keys.get(i)));
            noneCounter++;
        }
        if(noneCounter == -1) {
            System.out.println("No alias bands");
        }

    }
}