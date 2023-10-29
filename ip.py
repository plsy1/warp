def generate_ip_addresses(ip_segments):
    ip_addresses = []

    for segment in ip_segments:
        for i in range(2,255):
            ip = f"{segment}.{i}"
            ip_addresses.append(ip)

    return ip_addresses

def save_to_file(ip_addresses, filename):
    with open(filename, 'w') as file:
        for ip in ip_addresses:
            file.write(ip + '\n')

ip_segments = ["162.159.192", "162.159.193", "162.159.195", "162.159.204", "188.114.96", "188.114.97", "188.114.98", "188.114.99"]
ip_addresses = generate_ip_addresses(ip_segments)
save_to_file(ip_addresses, "ip.txt")
