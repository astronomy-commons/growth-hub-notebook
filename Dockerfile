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

