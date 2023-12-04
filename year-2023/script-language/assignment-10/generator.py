import random
import string


def generate_random_text(size_mb):
    chars = string.ascii_letters + string.digits + string.punctuation + string.whitespace
    text = ''.join(random.choice(chars) for _ in range(size_mb * 1024 * 1024))
    return text


def write_text_to_file(text, filename):
    with open(filename, 'w') as file:
        file.write(text)


text_size_mb = 122
random_text = generate_random_text(text_size_mb)

file_name = 'large_text_file.txt'
write_text_to_file(random_text, file_name)
