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
                new_line = f"- {{name: {warp_name}, type: wireguard, server: {ip}, port: {port}, ip: 172.16.0.2, public-key: , private-key: , mtu: 1280, udp: true}}\n"
                output_file.write(new_line)

    print("结果已保存到 res.txt 文件")

def replace_proxies_with_res(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    start_index = lines.index("proxies:\n")
    end_index = start_index + 51
    del lines[start_index+1:end_index]


    with open('res.txt', 'r') as res_file:
        res_lines = res_file.readlines()[:50]
        res_lines = ['  ' + line for line in res_lines]

    lines[start_index+1:start_index] = res_lines

    with open('warp.yaml', 'w') as output_file:
        output_file.writelines(lines)

    print("内容已替换并保存到 warp.yaml 文件中")


file_path = "result.csv"
process_csv(file_path)

file_path = 'warp.yaml'
replace_proxies_with_res(file_path)
