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
#    libopenblas-dev \
#    liblapack-dev \
#    texlive-latex-base \
#    texlive-latex-extra \
#    texlive-fonts-extra \
#    texlive-fonts-recommended \
#    texlive-generic-recommended \
    python-setuptools \
    python-pip \
    python-numpy \
    python-scipy \
#    libatlas-dev \
#    libatlas3gf-base \
#    sudo \
#    locales \
    libxrender1 \
    && apt-get clean


#RUN update-alternatives --set libblas.so.3 \
#      /usr/lib/atlas-base/atlas/libblas.so.3; \
#    update-alternatives --set liblapack.so.3 \
#      /usr/lib/atlas-base/atlas/liblapack.so.3


#RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
#    locale-gen

# Configure environment
#ENV CONDA_DIR /opt/conda
#ENV PATH $CONDA_DIR/bin:$PATH
#ENV SHELL /bin/bash
#ENV LC_ALL en_US.UTF-8
#ENV LANG en_US.UTF-8
#ENV LANGUAGE en_US.UTF-8
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

#RUN pip3 install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.6.0-cp34-none-linux_x86_64.whl

RUN pip install xgboost

ENV TENSORFLOW_VERSION 0.6.0
RUN pip --no-cache-dir install \
    https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-${TENSORFLOW_VERSION}-cp27-none-linux_x86_64.whl

VOLUME /notebook
WORKDIR /notebook
EXPOSE 8888
CMD ["ipython","notebook","--no-browser","--ip=0.0.0.0"]