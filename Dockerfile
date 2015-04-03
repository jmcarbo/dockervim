FROM ubuntu
RUN apt-get update && apt-get install -y git vim python-software-properties software-properties-common curl
RUN mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
RUN git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
RUN mkdir -p ~/.vim && cd ~/.vim && mkdir -p bundle && cd bundle && git clone git://github.com/klen/python-mode.git
ADD vimrc /root/.vimrc
RUN vim +PluginInstall +qall
