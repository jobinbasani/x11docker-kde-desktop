FROM ubuntu:bionic

ENV LANG=en_US.UTF-8
RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      locales && \
    echo "$LANG UTF-8" >> /etc/locale.gen && \
    locale-gen && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      kwin-x11 \
      plasma-desktop \
      plasma-workspace 

# Wayland: startplasmacompositor
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      kwin-wayland-backend-x11 kwin-wayland-backend-wayland && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      plasma-workspace-wayland && \
    sed -i 's/--libinput//' /usr/bin/startplasmacompositor
    
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      kubuntu-desktop \
      ssh \
      gimp \
      spectacle \
      audacity \
      libreoffice \
      jackd \
      pulseaudio-module-jack \
      libodbc1 \
      odbcinst1debian2 \
      chrony \
      libpcre16-3 \
      plasma-workspace-wallpapers \
      plasma-active-default-settings \
      gnome-themes-standard \
      samba \
      linux-generic \
      alsa-utils \
      vim \
      konsole \
      kwrite \
      libcups2 \
      libpulse0 \
      procps \
      psmisc \
      sudo \
      synaptic \
      systemsettings \
      nautilus \
      firefox \
      unattended-upgrades

# Dirty fix to avoid kdeinit error ind startkde. 
RUN apt remove -y bluedevil && \
    apt-get autoremove -y && \
    sed -i 's/.*kdeinit/###&/' /usr/bin/startkde

CMD startkde
