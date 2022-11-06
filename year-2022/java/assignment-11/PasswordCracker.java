import java.io.*;
import java.net.Socket;
import java.util.Objects;

public class PasswordCracker implements PasswordCrackerInterface {
    // dont smoke crack kids
    // connection //

    static int counter = 0;
    // crack
    final String host = "172.30.24.15";
    final int port = 8080;
    // local
    //final String host = "127.0.0.1";
    //final int port = 8080;
    // data
    int passwordCounter;
    String passwordScheme;
    StringBuilder crackedPass;
    // stuff
    Socket socket;
    BufferedReader fromServer;
    PrintWriter toServer;

   public static void main(String[] args) {
       PasswordCracker dd = new PasswordCracker();

       for (int i = 0; i < 10000; i++) {
           if(dd.getPassword(dd.host, dd.port) != null) {
               System.out.println("test "+counter +" ok");
               System.out.println();
           }
           
       }
       System.out.println(counter);

   }

    @Override
    public String getPassword(String host, int port) {
        try {
            socket = new Socket(host, port);
            fromServer = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            toServer = new PrintWriter(new OutputStreamWriter(socket.getOutputStream()), true);

            fromServer.readLine();  // ersja 1.0. Powitać! Z kim rozmawiam
            toServer.println("Program");
            fromServer.readLine();  // timeout: 2000 msec.
            passwordScheme = fromServer.readLine();     // schema : luslsuun
            fromServer.readLine();  // Zaczynamy! Zgadnij hasło.
            getScheme(passwordScheme);

            // generate start password
            passwordCheck();
            // try password
            toServer.println(crackedPass);
            String bufFromServer = "";
            // info
            bufFromServer = fromServer.readLine();
        
            // gets password counter
            passwordCounter = bufFromServer.charAt(25) - 48;


            int startCounter = passwordCounter;
            int tmp = 0;
            char dude;
            for (int i = 0; i < passwordScheme.length(); i++) {
                dude = passwordScheme.charAt(i);
                for (int j = 0; j < PasswordComponents.passwordComponents.get(dude).size(); j++) {
                    crackedPass.deleteCharAt(i);
                    crackedPass.insert(i, PasswordComponents.passwordComponents.get(dude).get(j));
                    toServer.println(crackedPass);
                    
                    // gets info
                    bufFromServer = fromServer.readLine();
                    

                    if (Objects.equals(bufFromServer, "+OK")) {
                        System.out.println(bufFromServer);
                        counter++;
                        return crackedPass.toString();
                    }
                    int prev = tmp;
                    tmp = bufFromServer.charAt(25) - 48;
                    if (tmp < prev) {
                        crackedPass.deleteCharAt(i);
                        crackedPass.insert(i, PasswordComponents.passwordComponents.get(dude).get(0));
                        break;
                    }
                    if (tmp > startCounter) {
                        startCounter++;
                        break;
                    }
                }
            }
            bufFromServer = fromServer.readLine();
            

        } catch (IOException e) {
            e.printStackTrace();
        }
        return crackedPass.toString();
    }


    // UTILITY //
    private void passwordCheck() {
        crackedPass = new StringBuilder();
        for (int i = 0; i < passwordScheme.length(); i++) {
            char dude = passwordScheme.charAt(i);
            crackedPass.append(PasswordComponents.passwordComponents.get(dude).get(0));
        }
        //System.out.println(crackedPass);
    }


    private void getScheme(String password) {
        StringBuilder tmp = new StringBuilder();
        for (int i = 9; i < password.length(); i++) {
            tmp.append(password.charAt(i));
        }
        passwordScheme = String.valueOf(tmp);
    }


}