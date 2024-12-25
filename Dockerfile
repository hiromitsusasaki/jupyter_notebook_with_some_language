FROM python:3.12.8

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    git \
    nodejs \
    npm \
    golang \
    libreadline-dev \
    libssl-dev \
    zlib1g-dev \
    libffi-dev \
    libyaml-dev \
    libzmq3-dev \
    cmake \
    zip \
    unzip \
    ninja-build \
    pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Ruby with rbenv
ENV PATH="/root/.rbenv/bin:/root/.rbenv/shims:$PATH"

RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    cd ~/.rbenv && src/configure && make -C src && \
    git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# Add rbenv initialization to shell
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc

# Install Ruby with proper initialization
SHELL ["/bin/bash", "-c"]
RUN source ~/.bashrc && \
    RUBY_CONFIGURE_OPTS="--enable-shared --with-libffi-source-dir=/usr/lib" rbenv install 3.3.6 && \
    rbenv global 3.3.6

# Install Node.js
RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
ENV PATH="$NVM_DIR/versions/node/v22.12.0/bin:$PATH"
ENV VCPKG_FORCE_SYSTEM_BINARIES=1
RUN . "$NVM_DIR/nvm.sh" && nvm install 22.12.0 && nvm use 22.12.0

# Install Go
RUN curl -OL https://golang.org/dl/go1.23.4.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz \
    && rm go1.23.4.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/root/go
ENV PATH=$PATH:$GOPATH/bin

# Set working directory
WORKDIR /workspace

# Install JupyterLab and kernels
RUN pip install jupyterlab
RUN pip install jupyter-server-proxy

# Install language kernels
RUN gem install iruby
RUN iruby register --force

# Install tslab and dependencies
RUN npm install -g node-gyp
RUN npm install -g zeromq@6.0.0-beta.19
RUN npm install -g tslab
RUN tslab install

RUN pip install bash_kernel
RUN python -m bash_kernel.install

RUN mkdir -p $GOPATH && \
    go install github.com/gopherdata/gophernotes@latest && \
    mkdir -p ~/.local/share/jupyter/kernels/golang && \
    cd ~/.local/share/jupyter/kernels/golang && \
    cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes@*/kernel/* .

# Copy dependency files
COPY Gemfile* ./
COPY requirements.txt ./
COPY package.json ./

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN bundle install
RUN npm install

# Expose JupyterLab port
EXPOSE 8888

# Start JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
