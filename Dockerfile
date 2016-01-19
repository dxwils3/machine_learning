FROM ubuntu:14.04

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
    texlive-latex-base \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    sudo \
    locales \
    libxrender1 \
    && apt-get clean
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.6.0/tini && \
    echo "d5ed732199c36a1189320e6c4859f0169e950692f451c03e7854243b95f4234b *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Configure environment
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV SHELL /bin/bash
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
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

VOLUME /notebook
WORKDIR /notebook
EXPOSE 8888
CMD ipython notebook --no-browser --ip=0.0.0.0
