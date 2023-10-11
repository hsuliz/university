import socket

server_address = ('localhost', 2020)
old_buf = ''


def parsing(input_data):
    global old_buf
    input_data = (old_buf.encode('utf-8') + input_data).decode('utf-8')
    current_buf = list()
    out_sum_arr = list()
    data_end = False
    out_sum = 0
    sum_buf = ''
    for i in range(len(input_data)):

        if input_data[i - 1] == '\r' and input_data[i] == '\n':
            data_end = True
        else:
            current_buf.append(input_data[i])
        if data_end:
            current_buf.pop()
            # sum
            try:
                error_flag = True
                for j in range(len(current_buf)):
                    error_flag = False
                    if current_buf[j].isdigit():
                        sum_buf += current_buf[j]
                        if j == len(current_buf) - 1:
                            out_sum += int(sum_buf)
                            sum_buf = ''
                    elif current_buf[j] == ' ' and current_buf[j + 1] != ' ':
                        out_sum += int(sum_buf)
                        sum_buf = ''
                    else:
                        error_flag = True
                        break
            except:
                error_flag = True
            # utility
            if error_flag or out_sum > 4294967295:  # overflowing max number
                out_sum_arr.append('ERROR\r\n')
            else:
                out_sum_arr.append(str(out_sum) + '\r\n')
            current_buf.clear()
            old_buf = ''
            out_sum = 0
            data_end = False
            sum_buf = ''  # funny buffer

    if current_buf:
        old_buf = ''
        old_buf = old_buf.join(current_buf)
    return out_sum_arr


def main():
    # server set-up
    serv_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    serv_socket.bind(server_address)
    serv_socket.listen(1)

    while True:
        connection, client = serv_socket.accept()
        try:
            while True:
                input_data = connection.recv(1024)
                if not input_data:
                    break
                out_data = parsing(input_data)
                for i in range(len(out_data)):
                    print(out_data[i].encode('utf-8'))
                    connection.send(out_data[i].encode('utf-8'))

        finally:
            connection.close()


if __name__ == '__main__':
    main()
