FROM jupyter/base-notebook:latest

USER root

# 必要なパッケージのインストールとクリーンアップ
RUN apt-get update && \
    apt-get install -y libtool libffi-dev ruby ruby-dev make git libzmq3-dev autoconf pkg-config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# CZMQのインストール
RUN git clone https://github.com/zeromq/czmq /home/jovyan/czmq && \
    cd /home/jovyan/czmq && \
    ./autogen.sh && ./configure && make && make install

# Ruby関連のセットアップ
WORKDIR /home/jovyan
RUN gem install cztop iruby bundler && \
    iruby register --force

# Gemfileのコピーとbundle update
COPY Gemfile* /home/jovyan/
RUN bundle update

# Google Credentialのコピー
COPY google_credential.json /home/jovyan

# パーミッションの設定
RUN chown -R jovyan:users /home/jovyan

USER jovyan

CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.password=''", "--NotebookApp.disable_check_xsrf=True"]
