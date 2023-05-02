import can

__COMMAND = "LD"
_COMMAND = [ord(c) for c in __COMMAND]

# BINARY_DATA_FILENAME = "cantest.exe"
BINARY_DATA_FILENAME = "slick.bin"
# BINARY_DATA_FILENAME = "100KB.bin"

def load_binary_file(filename):
    with open(filename, mode='rb') as f:
        data = f.read()
    return data

def pocket_generator(data):
    fcount = (len(data) // 4) * 4
    # print(fcount)
    i = 0
    pocket = _COMMAND + [0]*6

    while(i < fcount):
        pocket[4] = data[i + 0]
        pocket[5] = data[i + 1]
        pocket[6] = data[i + 2]
        pocket[7] = data[i + 3]

        i+=4

        pocket[2] = i // 256
        pocket[3] = i % 256
        # print("Pocket [{}] > {}".format(i, pocket))

        yield pocket

    tail = len(data) - fcount
    pocket[4] = 0; pocket[5] = 0; pocket[6] = 0; pocket[7] = 0
    for k in range(tail):
        pocket[4 + k] = data[fcount + k]
    pocket[2] = (i + tail) // 256
    pocket[3] = (i + tail) % 256
    # print("Pocket [{}] > {}".format(i, pocket))
    yield pocket


def send_binary_data(bus, data, arb_id=0x1FFFFFFF):
    for pocket in pocket_generator(data):
        print("Pocket [{}] > {}".format(i, pocket))
        continue
        msg = can.Message(
            arbitration_id=arb_id,
            data=pocket,
            is_extended_id=True
        )y
        try:
            bus.send(msg)
            print(f"Message sent on {bus.channel_info}")
        except can.CanError:
            print("Message NOT sent")

def main():
    data = load_binary_file(BINARY_DATA_FILENAME)
    print(type(data))
    print(len(data))
    bus = None #can.Bus(interface='socketcan', channel='vcan0', bitrate=250000)
    send_binary_data(bus, data)
    # print(data)

if __name__ == "__main__":
    main()
