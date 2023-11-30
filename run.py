import subprocess
import time

# Adjust this to your expected judgehost number
TASKS = 30


def main():
    for i in range(TASKS):
        subprocess.Popen(
            f"while true; do sudo ./judgescale -P {i} ./prog 2>/dev/null ; done",
            shell=True,
        )
    while True:
        time.sleep(1000)


if __name__ == "__main__":
    main()
