FROM ubuntu
RUN apt-get update && apt-get install -y git vim python-software-properties software-properties-common curl gcc libc6-dev make
RUN mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
RUN git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
RUN mkdir -p ~/.vim && cd ~/.vim && mkdir -p bundle && cd bundle && git clone git://github.com/klen/python-mode.git
ADD vimrc /root/.vimrc
RUN vim +PluginInstall +qall
RUN mkdir -p ~/.vim/UltiSnips
ADD python.snippets /root/.vim/UltiSnips/python.snippets
ADD xml.snippets /root/.vim/UltiSnips/xml.snippets
ADD sh.snippets /root/.vim/UltiSnips/sh.snippets

# Golang
ENV GOLANG_VERSION 1.4.2
RUN curl -sSL https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz \
		| tar -v -C /usr/src -xz
RUN cd /usr/src/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/src/go/bin:$PATH
RUN mkdir -p /go/src /go/bin && chmod -R 777 /go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
ENV GOBIN $GOPATH/bin
WORKDIR /go
COPY go-wrapper /usr/local/bin/
RUN vim +GoInstallBinaries +qall

# Allow web development
EXPOSE 80
