FROM opensuse/leap:latest
RUN zypper --non-interactive install autoconf automake bash bison bzip2 cmake flex gcc-32bit gcc-c++ gdk-pixbuf-devel gettext-tools git glibc-devel-32bit gperf gzip intltool lftp libopenssl-devel libtool lzip make pango-devel pcre-devel p7zip-full patch perl perl-XML-Parser python311 python311-pip ruby sed scons unzip wget xz
RUN ln -sf /usr/bin/python3.11 /usr/bin/python3
RUN ln -sf /usr/bin/python3.11 /usr/bin/python
RUN pip3 install mako-render
RUN git clone https://github.com/highperformancecoder/mxe.git
RUN cd mxe; git checkout mxe-for-minsky
RUN cd mxe; make JOBS=4 -j2 MXE_TARGETS=x86_64-w64-mingw32.shared boost gsl librsvg openssl readline ncurses cairo pango 
# currently, the tk build is failing when built under docker
#RUN cd mxe; make JOBS=4 -j2 MXE_TARGETS=x86_64-w64-mingw32.shared MXE_PLUGIN_DIRS=plugins/tcl.tk tk
