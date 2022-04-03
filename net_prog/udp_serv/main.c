#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdbool.h>

#define PORT 2020
#define MAXLINE 65527

// Driver code
int main() {
    int sock_fd;

    // Creating socket file descriptor
    if ((sock_fd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("socket creation failed");
        exit(EXIT_FAILURE);
    }

    // Filling server information
    struct sockaddr_in servaddr;
    servaddr.sin_family = AF_INET; // IPv4
    servaddr.sin_addr.s_addr = INADDR_ANY;
    servaddr.sin_port = htons(PORT);

    // Bind the socket with the server address
    if (bind(sock_fd, (const struct sockaddr *) &servaddr,
             sizeof(servaddr)) < 0) {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }

    while (1) {
        struct sockaddr_in cliaddr;
        bool error_status = false;
        char buffer[MAXLINE];
        char num_buf[MAXLINE];
        char string_buf[MAXLINE];
        int n;
        unsigned long int sum = 0;
        socklen_t cli_len = sizeof(cliaddr);  //len is value/resuslt

        // gets user data
        n = recvfrom(sock_fd, buffer, sizeof(buffer), 0,
                     (struct sockaddr *) &cliaddr, &cli_len);
        buffer[n] = '\0';

        //
        int j = 0;
        for (int i = 0; i <= n; ++i) {
            if(buffer[0] == 13 || j == 21) {
                error_status = true;
                break;
            }
            if ((buffer[i] >= 33 && buffer[i] <= 47) || buffer[i] >= 58) {
                error_status = true;
                break;
            }
            // adding to queue
            if (buffer[i] <= '9' && buffer[i] >= '0' || (buffer[i] == '\r' && buffer[i + 1] == '\n')) {
                string_buf[j] = buffer[i];
                ++j;
            } else if (buffer[i] == ' ' || buffer[i] == '\n') {
                sum += strtoul(string_buf, NULL, 0);
                memset(string_buf, j, MAXLINE);
                j = 0;
            }
        }
        if(sum == 0) {
            error_status = true;
        }


        // data send
        if (error_status) {
            char *error_message = "ERROR\n";
            printf("%s", error_message);
            sendto(sock_fd, (const char *) error_message, strlen(error_message),
                   0, (const struct sockaddr *) &cliaddr,
                   cli_len);

        } else {
            char *out_data[MAXLINE];
            printf("%lu\n", sum);
            sprintf(out_data, "%lu", sum);
            sendto(sock_fd, (const char *) out_data, strlen(out_data),
                   0, (const struct sockaddr *) &cliaddr,
                   cli_len);
        }

    }
}