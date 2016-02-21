FROM debian:jessie

RUN apt-get update
RUN apt-get install python python-pip -y

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list
RUN echo "deb http://download.mono-project.com/repo/debian wheezy-apache24-compat main" | tee -a /etc/apt/sources.list.d/mono-xamarin.list
RUN echo "deb http://download.mono-project.com/repo/debian wheezy-libjpeg62-compat main" | tee -a /etc/apt/sources.list.d/mono-xamarin.list
RUN apt-get update
RUN apt-get install -y mono-complete
RUN apt-get install -y mono-vbnc
RUN apt-get install -y vim git
RUN apt-get install -y unzip
RUN apt-get install -y wget
RUN mkdir /dwsim
RUN cd /dwsim && wget http://enophook.resisty.net/~torstein/IronPython-2.7.5.zip && unzip IronPython-2.7.5.zip
RUN mkdir /dwsim/dwsimlib
RUN cd /dwsim/dwsimlib && wget "http://downloads.sourceforge.net/project/dwsim/DWSIM/DTL/DWSIM_Standalone_Thermodynamics_Library_v3.2.0.zip?r=&ts=1455993889&use_mirror=netcologne" -O DWSIM_Standalone_Thermodynamics_Library_v3.2.0.zip && unzip DWSIM_Standalone_Thermodynamics_Library_v3.2.0.zip
RUN cd /dwsim && wget https://bitbucket.org/hpk42/execnet/raw/80baab4140de/execnet/script/socketserver.py

RUN sed s/loop=False/loop=True/ /dwsim/socketserver.py > /dwsim/socketserver2.py

EXPOSE 8888
