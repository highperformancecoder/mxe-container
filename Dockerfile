FROM opensuse/leap:latest
RUN zypper --non-interactive install autoconf automake bash bison libboost_date_time1_75_0-devel bzip2 cmake flex gcc-32bit gcc-c++ gdk-pixbuf-devel gettext-tools git glibc-devel-32bit gperf gzip intltool lftp libopenssl-devel libtool lzip make pango-devel pcre-devel p7zip-full patch perl perl-XML-Parser python311 python311-pip ruby sed scons unzip wget xz
RUN ln -sf /usr/bin/python3.11 /usr/bin/python3
RUN ln -sf /usr/bin/python3.11 /usr/bin/python
RUN pip3 install mako-render
RUN git clone https://github.com/highperformancecoder/mxe.git
RUN cd mxe; git checkout mxe-for-minsky
RUN cd mxe; make JOBS=4 -j2 MXE_TARGETS=x86_64-w64-mingw32.shared boost cairo gsl librsvg ncurses openssl pango readline sqlite
# currently, the tk build is failing when built under docker
#RUN cd mxe; make JOBS=4 -j2 MXE_TARGETS=x86_64-w64-mingw32.shared MXE_PLUGIN_DIRS=plugins/tcl.tk tk
ADD . root
ENV PATH="/mxe/usr/bin:$PATH"
RUN cd root; tar zxvf soci-4.0.3.tar.gz
RUN cd root/soci-4.0.3; x86_64-w64-mingw32.shared-cmake -DSOCI_CXX11=on .
RUN cd root/soci-4.0.3; make -j4 install
RUN for i in /mxe/usr/x86_64-w64-mingw32.shared/lib/libsoci*_4_0.a; do ln -sf $i ${i%%_4_0.a}.a; done
