# machine_learning
This repository will house explorations in machine_learning.

The Dockerfile contains a docker image that can be used to run these notebooks.  The docker will install scikit-learn, xgboost, numpy, scipy, theano, tensorflow, keras, and the jupyter notebook.  If you don't have Docker, you can get installation instructions [here](https://docs.docker.com/engine/installation/).

Clone this repository onto your local machine.  We'll call this directory ```LOCAL_DIR```, which on my machine is ```/Users/dxwils3/git/machine_learning```.

To install the Docker image, run
```docker run -d -p 8888:8888 -v LOCAL_DIR:/notebook dxwils3/machine_learning```, which will pull the pre-built image from docker hub.

This will mount the directory LOCAL_DIR as /notebook in the container, which will be the jupyter notebook home directory.

To get to the jupyter notebook, visit ```localhost:8888``` on Unix or Windows, or ```dockerhost:8888``` on Mac OSX, assuming you are using docker-osx-dev.

To get a shell on this running docker, use ```docker exec -i -t CONTAINER_ID bash``` where container id is given by executing ```docker ps```.
