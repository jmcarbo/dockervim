FROM ubuntu
RUN apt-get update && apt-get install -y git vim python-software-properties software-properties-common curl wget unzip gcc libc6-dev make tmux
RUN mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
RUN git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
RUN mkdir -p ~/.vim && cd ~/.vim && mkdir -p bundle && cd bundle && git clone git://github.com/klen/python-mode.git
ADD vimrc /root/.vimrc
RUN vim +PluginInstall +qall
RUN mkdir -p ~/.vim/UltiSnips
ADD python.snippets /root/.vim/UltiSnips/python.snippets
ADD xml.snippets /root/.vim/UltiSnips/xml.snippets
ADD sh.snippets /root/.vim/UltiSnips/sh.snippets

# Allow web development
RUN wget https://github.com/mholt/caddy/releases/download/v0.5.1/caddy_linux_amd64.zip
RUN unzip caddy_linux_amd64.zip
RUN install caddy_linux_amd64 /usr/local/bin/caddy

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
ADD go.snippets /root/.vim/UltiSnips/go.snippets

ADD extjs /go/src/extjs
ADD html.snippets /root/.vim/UltiSnips/html.snippets
ADD javascript.snippets /root/.vim/UltiSnips/javascript.snippets

# install meteor
RUN curl https://install.meteor.com/ | sh

RUN mkdir /root/.vim/UltiSnips/javascript /root/.vim/UltiSnips/html
ADD angular_js.snippets /root/.vim/UltiSnips/javascript/angular_js.snippets
ADD angular_html.snippets /root/.vim/UltiSnips/html/angular_html.snippets

EXPOSE 2015 80 3000
