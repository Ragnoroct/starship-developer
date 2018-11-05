import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from pathlib import Path
import hashlib
import os.path
import subprocess

class Watcher:
    DIRECTORY_TO_WATCH = str((Path(__file__).parent / ".."))

    def __init__(self):
        self.observer = Observer()

    def run(self):
        print("> watching directory ", str(Path(self.DIRECTORY_TO_WATCH).resolve()) + "...")
        event_handler = Handler()
        self.observer.schedule(event_handler, self.DIRECTORY_TO_WATCH, recursive=True)
        self.observer.start()
        try:
            while True:
                time.sleep(.5)
                Handler.batchFiles()
        except KeyboardInterrupt:
            return

        self.observer.join()


class Handler(FileSystemEventHandler):
    hashes = {}
    toBatch = {}

    @classmethod
    def processFile(cls, path: Path):
        #Process Aseprite
        if str(path).endswith(".aseprite") or str(path).endswith(".ase"):
            # aseprite.exe -b image.ase --save-as image.png
            pre, ext = os.path.splitext(str(path.resolve()))
            asePath = str(path.resolve())
            pngPath = pre + ".png"
            if asePath != pngPath:
                rt = subprocess.run(["Aseprite.exe", "-b", asePath, "--save-as", pngPath], capture_output=True)
                if rt.returncode == 0:
                    #Success
                    print("> exported aseprite", pngPath)
                else:
                    raise Exception("ERROR: \n" + "return code: " + str(rt.returncode) + "\nstdout: " + str(rt.stdout) + "\nstderr: " + str(rt.stderr))
            else:
                raise Exception("ERROR: aseprite file path and target png file path are the same.")
        
    @classmethod
    def batchFiles(cls):
        currentBatch = cls.toBatch.copy()
        for path in currentBatch:
            if Path(path).exists() == False or Path(path).suffix = ".tmp":
                continue
            fileContents = Path(path).read_bytes()
            hashValue = hashlib.md5(fileContents).hexdigest()
            if path not in cls.hashes or cls.hashes[path] != hashValue:
                cls.processFile(Path(path))
            cls.hashes[path] = hashValue
        cls.toBatch = {}
    
    @classmethod
    def on_any_event(cls, event):
        if event.is_directory:
            return None

        elif event.event_type == 'created':
            cls.toBatch[event.src_path] = True

        elif event.event_type == 'modified':
            cls.toBatch[event.src_path] = True

if __name__ == '__main__':
    w = Watcher()
    w.run()