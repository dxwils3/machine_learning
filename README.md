# machine_learning
This repository will house explorations in machine_learning.

To install the Docker image, run
```docker run -d -p 8888:8888 -v LOCAL_DIR:/notebook dxwils3/machine_learning```

This will mount the directory LOCAL_DIR as /notebook in the container, which will be the jupyter notebook home directory.

To get to the jupyter notebook, visit ```localhost:8888``` on Unix or Windows, or ```dockerhost:8888``` on Mac OSX, assuming you are using docker-osx-dev.
