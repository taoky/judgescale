#!/usr/bin/env python3
import subprocess
import time
import signal
from typing import List, IO
import sys
import os
from datetime import datetime

# Adjust this to your expected judgehost number
TASKS = 30
tasks: List[subprocess.Popen] = []
files: List[IO] = []


def cleanup(signum, frame):
    for task in tasks:
        task.terminate()
    for file in files:
        file.close()
    sys.exit(0)


signal.signal(signal.SIGINT, cleanup)
signal.signal(signal.SIGTERM, cleanup)


def main():
    os.makedirs("logs", exist_ok=True)
    for i in range(TASKS):
        f = open(f"logs/{i}.log", "w")
        f.writelines([f"Start time: {datetime.now()}"])
        tasks.append(
            subprocess.Popen(
                f"while true; do sudo ./judgescale -P {i} ./prog 2>/dev/null ; done",
                shell=True,
                stdin=None,
                stdout=f,
            )
        )
        files.append(f)
    while True:
        time.sleep(1000)


if __name__ == "__main__":
    main()
