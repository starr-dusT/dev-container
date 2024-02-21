# https://github.com/starr-dusT/dev-container

FROM "alpine:edge"

##### BASE CONFIG #####
 
# Install edge repo
RUN echo https://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN apk --no-check-certificate update

# Install Alpine packages for python
RUN apk add --no-check-certificate --virtual .base-python \
    python3 py3-pip ipython py3-matplotlib py3-psutil jupyter-notebook py3-tornado

# Install Alpine build dependices for pip installs
RUN apk add --no-check-certificate --virtual .build-deps \
    alpine-sdk cmake gfortran openblas-dev hdf5-dev \
    python3-dev py3-numpy-dev jpeg-dev py3-qt5

# Install pip packages for python
RUN pip install \
    --break-system-packages --trusted-host pypi.org --trusted-host files.pythonhosted.org \
    ipykernel ipympl pandas numpy cadquery

# Install other useful packages
RUN apk add --no-check-certificate --virtual .useful-packs \
    bash tmux git openssh vim nano curl

##### PERSONAL CONFIG #####

# clone dotfiles
RUN sh -c "$(curl -fsLS get.chezmoi.io)"
ENV PATH="/root/bin:${PATH}"
RUN chezmoi init --apply https://github.com/starr-dusT/dotfiles

# Install other useful packages
RUN apk add --no-check-certificate --virtual .user-packs \
    neovim cargo npm go

# Install plugins in image and Mason LSPs 
RUN nvim --headless "+Lazy! sync" +qa
RUN nvim --headless +"MasonInstall pyright typescript-language-server lua-language-server beancount-language-server gopls" +q

WORKDIR /root
CMD ["/bin/bash"]
