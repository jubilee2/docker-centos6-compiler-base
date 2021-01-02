FROM centos:6

RUN INSTALL_PKGS="devtoolset-8 rh-python36 curl git wget tar boost-devel swig zip cmake make" && \
    yum install -y centos-release-scl && \
    yum -y --setopt=tsflags=nodocs install $INSTALL_PKGS && \
    yum clean all

RUN source /opt/rh/devtoolset-8/enable && \
    wget https://cmake.org/files/v3.15/cmake-3.15.7.tar.gz && \
    tar zxvf cmake-3.15.7.tar.gz && rm -f cmake-3.15.7.tar.gz && \
    cd cmake-3.15.7 && \
    ./bootstrap --prefix=/usr/local && \
    make -j$(nproc) && \
    make install

RUN scl enable rh-python36 "curl https://bootstrap.pypa.io/get-pip.py | python" && \
    scl enable rh-python36 "pip install FoBiS.py future configparser"
