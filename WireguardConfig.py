import csv

def process_csv(file_path):
    with open(file_path, 'r') as file:
        reader = csv.reader(file)

        next(reader)

        with open('res.txt', 'w') as output_file:
            for i, row in enumerate(reader, start=1):
                ip_port = row[0].strip()
                ip, port = ip_port.split(":")
                warp_name = f"Warp{i:02d}"
                new_line = f"- {{name: {warp_name}, type: wireguard, server: {ip}, port: {port}, ip: 172.16.0.2, public-key: xxxxxxxxxxx, private-key: xxxxxxxxx, mtu: 1280, udp: true}}\n"
                output_file.write(new_line)

    print("结果已保存到 res.txt 文件")


file_path = 'result.csv'

process_csv(file_path)
