#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

echo "Starting post-create script..."

# Update package lists
sudo apt-get update

# Install essential build dependencies from Dockerfile.buster (sonic-build tag 202012.0)
# Note: Some SONiC internal -dev packages might not be found in public apt repos.
# If apt-get install fails for them, they are typically built from source by the SONiC build system.
echo "Installing APT packages..."
sudo apt-get install -y --no-install-recommends \
    apt-utils \
    bison \
    ccache \
    cmake \
    curl \
    devscripts \
    dh-python \
    doxygen \
    equivs \
    fakeroot \
    flex \
    g++ \
    gcc \
    git \
    graphviz \
    iproute2 \
    jq \
    libacl1-dev \
    libaio-dev \
    libavl-dev \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-iostreams-dev \
    libboost-program-options-dev \
    libboost-python-dev \
    libboost-serialization-dev \
    libboost-system-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libbsd-dev \
    libbz2-dev \
    libc-ares-dev \
    libcurl4-openssl-dev \
    libdb-dev \
    libedit-dev \
    libevent-dev \
    libexpat-dev \
    libffi-dev \
    libfreetype6-dev \
    libgcrypt20-dev \
    libglib2.0-dev \
    libgnutls28-dev \
    libgpiod-dev \
    libgtest-dev \
    libhiredis-dev \
    libi2c-dev \
    libidn11-dev \
    libjansson-dev \
    libjemalloc-dev \
    libldap2-dev \
    liblmdb-dev \
    liblua5.3-dev \
    liblzma-dev \
    libmnl-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libnl-3-dev \
    libnl-genl-3-dev \
    libnl-route-3-dev \
    libnotify-dev \
    libp11-kit-dev \
    libpcap-dev \
    libpcre3-dev \
    libpipeline-dev \
    libplatform-dev \
    libpng-dev \
    libprotobuf-dev \
    libpython3-dev \
    libreadline-dev \
    librpc-xml-dev \
    libsasl2-dev \
    libsensors4-dev \
    libsnmp-dev \
    libsqlite3-dev \
    libssl-dev \
    libstdc++-arm-none-eabi-newlib \
    libswsscommon-dev \
    libsystemd-dev \
    libteam-dev \
    libtool \
    libunwind-dev \
    libusb-1.0-0-dev \
    libxml2-dev \
    libxmlrpc-core-c3-dev \
    libxslt1-dev \
    libxtables-dev \
    libyaml-dev \
    libyang-dev \
    libzbar-dev \
    libzstd-dev \
    lsb-release \
    lsof \
    make \
    net-tools \
    patch \
    pkg-config \
    procps \
    protobuf-compiler \
    psmisc \
    python-all-dev \
    python-daemon \
    python-dev \
    python-setuptools \
    python-sphinx \
    python-yaml \
    python3 \
    python3-all-dev \
    python3-click \
    python3-dev \
    python3-docker \
    python3-evdev \
    python3-future \
    python3-hjson \
    python3-ipaddr \
    python3-jinja2 \
    python3-junit.xml \
    python3-mako \
    python3-markupsafe \
    python3-netaddr \
    python3-netifaces \
    python3-nose2 \
    python3-numpy \
    python3-packaging \
    python3-pexpect \
    python3-pil \
    python3-pip \
    python3-ply \
    python3-prettytable \
    python3-pyasn1 \
    python3-pyasn1-modules \
    python3-pyroute2 \
    python3-pytest \
    python3-redis \
    python3-renderpm \
    python3-reportlab \
    python3-requests \
    python3-setuptools \
    python3-six \
    python3-slugify \
    python3-sortedcontainers \
    python3-stdeb \
    python3-tabulate \
    python3-termcolor \
    python3-thrift \
    python3-venv \
    python3-wheel \
    python3-yaml \
    python3-zmq \
    rsync \
    snmp \
    sudo \
    swig \
    sysstat \
    tcpdump \
    texlive-latex-extra \
    texlive-fonts-recommended \
    unzip \
    uuid-dev \
    wget \
    zip \
    zlib1g-dev

echo "Installing Python PIP packages..."
# Upgrade pip and install specific versions of Python packages as per Dockerfile.buster
sudo pip3 install --upgrade pip wheel setuptools
sudo pip3 install --upgrade jinja2==2.11.3 virtualenv==20.4.0
sudo pip3 install --upgrade stdeb3==0.9.1
sudo pip3 install --upgrade SQLAlchemy==1.3.23
sudo pip3 install --upgrade jsonschema==3.2.0
sudo pip3 install --upgrade scapy==2.4.5

# Additional Python packages from sonic-utilities requirements
sudo pip3 install ansible==2.9.10 jmespath

echo "Cleaning up APT cache..."
# Clean up APT cache to save space
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

echo "Post-create script finished."
echo "NOTE: Go language environment is NOT installed by this script but is part of the reference Dockerfile.buster."
echo "NOTE: Some SONiC-internal -dev packages (e.g., libswsscommon-dev) might have failed to install if not found in public APT repositories. These are typically built from source by the SONiC build system."