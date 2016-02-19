FROM krallin/ubuntu-tini:trusty

MAINTAINER dxwils3@gmail.com

RUN apt-get update && apt-get install -yq --no-install-recommends \
    git \
    curl \
    vim \
    wget \
    build-essential \
    python-dev \
    ca-certificates \
    bzip2 \
    unzip \
    libsm6 \
    pandoc \
    emacs \	   
    subversion \
    gfortran \
    python-setuptools \
    python-pip \
    python-numpy \
    python-scipy \
    libxrender1 \
    && apt-get clean


ENV PATH=/root/miniconda2/bin:$PATH


RUN curl -qsSLkO \
    https://repo.continuum.io/miniconda/Miniconda-latest-Linux-`uname -p`.sh \
  && bash Miniconda-latest-Linux-`uname -p`.sh -b \
  && rm Miniconda-latest-Linux-`uname -p`.sh

RUN conda install --yes \
    'notebook=4.0*' \
    terminado \
    && conda clean -yt

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
  && rm -rf /var/lib/apt/lists/*

RUN conda install -y \
    h5py \
    pandas \
    theano \
  && pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git \
  && pip install keras

RUN conda install -y \
    jupyter \
    matplotlib \
    seaborn \
    scikit-learn

RUN pip install xgboost

ENV TENSORFLOW_VERSION 0.6.0
RUN pip --no-cache-dir install \
    https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-${TENSORFLOW_VERSION}-cp27-none-linux_x86_64.whl

RUN pip install https://bitbucket.org/netplngt/tools/get/617986254069.zip

VOLUME /notebook
WORKDIR /notebook
EXPOSE 8888
CMD ["ipython","notebook","--no-browser","--ip=0.0.0.0"]