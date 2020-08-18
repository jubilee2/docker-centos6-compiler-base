FROM centos:6

RUN INSTALL_PKGS="devtoolset-8 rh-python36 curl git wget tar boost-devel swig zip cmake make" && \
    yum install -y centos-release-scl && \
    yum -y --setopt=tsflags=nodocs install $INSTALL_PKGS && \
    source /opt/rh/devtoolset-8/enable && \
    wget https://cmake.org/files/v3.12/cmake-3.12.3.tar.gz && \
    tar zxvf cmake-3.12.3.tar.gz && rm -f cmake-3.12.3.tar.gz && \
    cd cmake-3.12.3 && \
    ./bootstrap --prefix=/usr/local && \
    make -j$(nproc) && \
    make install && \
    cd / && \
    scl enable rh-python36 "curl https://bootstrap.pypa.io/get-pip.py | python" && \
    scl enable rh-python36 "pip install FoBiS.py future configparser"