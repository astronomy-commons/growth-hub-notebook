FROM jupyter/base-notebook

USER root

RUN apt-get update \
 && apt-get -y install apt-file \
 && apt-file update \
 && apt-get -y install \
    vim \
    cron \
    git \
    sextractor \
    psfex \
    swarp \
    scamp \
 && apt-get clean

USER $NB_UID

RUN conda install --yes \
    numpy \
    astropy \
    scipy \
    matplotlib \
    pytest \
    requests \
    astroquery \
    photutils \
    emcee \
    corner \
    nbresuse \
    widgetsnbextension \
    nbgitpuller \
 && conda clean --all -f -y

RUN pip install \
    image_registration

# Updated version of start.sh, that doesn't mess with the jovyan user
COPY start.sh /usr/local/bin/

# Add jupyter-desktop-server
USER root

RUN apt-get -y update \
 && apt-get install -y dbus-x11 \
   firefox \
   xfce4 \
   xfce4-panel \
   xfce4-session \
   xfce4-settings \
   xorg \
   xubuntu-icon-theme

USER $NB_USER
RUN conda install -c manics websockify \
 && pip install jupyter-desktop-server

# Add ds9
USER root
RUN apt-get install -y curl \
    build-essential \
    libx11-dev \
    tk-dev \
    zlib1g-dev \
    libxml2-dev \
    libxslt-dev \
    libxft-dev \
    tcl-dev \
    automake \
    autoconf \
    zip

RUN cd /tmp && curl -O http://ds9.si.edu/download/source/ds9.8.1.tar.gz 
RUN cd /tmp \
 && tar -xzvf ds9.8.1.tar.gz \
 && cd SAOImageDS9 \
 && unix/configure \
 && make
RUN mv /tmp/SAOImageDS9/bin/ds9 /usr/local/bin/.

RUN apt-get install -y  vim emacs

COPY ds9.desktop $HOME/Desktop/.
USER $NB_USER

