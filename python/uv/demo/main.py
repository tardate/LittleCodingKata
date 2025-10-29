import time
from rich.progress import track

def main():
    for i in track(range(20), description="For example:"):
        time.sleep(0.05)

if __name__ == "__main__":
    main()
