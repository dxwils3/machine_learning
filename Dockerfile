FROM jupyter/minimal-notebook

USER root

# Install dependencies
RUN apt-get update && apt-get install -yq --no-install-recommends \
    curl \
    emacs \
    subversion \
    python3-setuptools \
    python3-pip \
    python3.4-dev \
    gfortran \
    libopenblas-dev \
    liblapack-dev

RUN conda update --all -y

RUN conda install -y numpy

RUN conda install -y \
    scipy \
    h5py \
    matplotlib \
    seaborn \
    jupyter \
    scikit-learn \
    pandas \
    theano \
    six \
    && conda clean -yt

RUN pip3 install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.6.0-cp34-none-linux_x86_64.whl

# Install ML components

RUN pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git

RUN pip install xgboost keras

USER jovyan
