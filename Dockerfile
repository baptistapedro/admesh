FROM fuzzers/afl:2.52

RUN apt-get update
RUN apt install -y build-essential wget git clang cmake  automake autotools-dev  libtool zlib1g zlib1g-dev libexif-dev libjpeg-dev libpng-dev
RUN git clone https://github.com/admesh/admesh.git
WORKDIR /admesh
RUN cmake -DCMAKE_C_COMPILER=afl-clang -DCMAKE_CXX_COMPILER=afl-clang++ .
RUN make
RUN make install
RUN mkdir /admeshCorpus
RUN cp ./examples/*.stl /admeshCorpus

ENTRYPOINT  ["afl-fuzz", "-i", "/admeshCorpus", "-o", "/admeshOut"]
CMD ["/admesh/admesh", "@@"]
