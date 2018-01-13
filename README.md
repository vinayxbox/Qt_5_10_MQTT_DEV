# Qt_5_10_MQTT_DEV
Development environment for MQTT based on Qt 5.10.0 (Qt Creator IDE), QtMqtt and Mosquitto Broker. CentOS 7.4.1708 is used as based image.

A MQTT development environment based on
1.) Qt 5.10.0 (Development framework). http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run (Community Edition)
2.) QtMqtt(MQTT client library.) https://github.com/qt/qtmqtt.git
3.) Mosquitto Broker (MQTT broker). https://mosquitto.org/download/
4.) Development tool chain has been updated to 7.2.1(Latest).
5.) Packages has been installed so that GUI application like Qt Creator IDE can run in Container.

To run the Qt Creator in the container execute below commands

#Important to run GUI apps from the container
xhost local:root

#Build the docker image.
docker build --no-cache -t  qt_5.10_mqtt_install .

#Run the through the installation wizard for installation. 
***********(Before you close the Installation wizard follow the next steps)*************
docker run -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v /dev/shm:/dev/shm --name qt_dev_5_10_install_con --entrypoint /home/qt-unified-linux-x64-online.run qt_5.10_mqtt_install

#Execute below commad in different termianl to access the terminal of our container
docker exec -it qt_dev_5_10_install_con /bin/bash

#In our Docker container execute below commands
git clone https://github.com/qt/qtmqtt.git

cd qtmqtt

#Below steps will build and install QtMqtt components for Qt 5.10.0  
<PathToQmake> i.e. if you don't change my default it will be /opt/Qt/5.10.0/gcc_64/bin/qmake
For example
/opt/Qt/5.10.0/gcc_64/bin/qmake qtmqtt.pro -spec linux-g++
make 
make install


#Save the image with Qt instllation in it from some other terminal. After this you can remove the old image and container
docker commit qt_dev_5_10_install_con qt_5_10_mqt_dev

docker run -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v /dev/shm:/dev/shm --name qt_dev_5_10_install_con --entrypoint /opt/Qt/Tools/QtCreator/bin/qtcreator qt_5_10_mqt_dev:latest

Issues you may found while running Qt Creator in container
1.) SElinux issue (Kindly see the SELinux troubleshooter window in your host machine).
