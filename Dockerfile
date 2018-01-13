FROM centos:7.4.1708

Maintainer Vinay Kumar Tiwari "vinayxbox@gmail.com"

#Installing Developement tools 
RUN yum group -y install "Development Tools"

RUN whereis gcc

RUN gcc --version

#Updating the tool chain to version 7
RUN yum -y install centos-release-scl-rh
RUN yum -y --enablerepo=centos-sclo-rh-testing install devtoolset-7-gcc devtoolset-7-gcc-c++

#Installing required packages for Qt Creator to run
RUN yum -y update && yum -y install botan wget clucene09-core glx-utils mesa-libGLES \
gstreamer-plugins-base libX11 libXrender libXi libXfixes libXext libxslt qt-x11 \
libxkbcommon libxcb xcb-util-image xcb-util-keysyms xcb-util-renderutil \
xcb-util-wm freetype fontconfig git

#Beginning Qt instllation
RUN wget http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run -P /home/
RUN chmod +x /home/qt-unified-linux-x64-online.run

ENTRYPOINT /bin/bash




