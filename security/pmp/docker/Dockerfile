ARG FROM_REPO=ubuntu
ARG FROM_VERSION=22.04
FROM --platform=linux/amd64 ${FROM_REPO}:${FROM_VERSION}

# ARG UID
# ARG GID
ENV UID=1001
ENV GID=1001
ENV USERNAME=pmp

RUN apt update && \
    apt install unzip && \
    apt install -y sudo && \
    addgroup --gid $GID $USERNAME && \
    adduser --uid $UID --gid $GID --disabled-password --gecos "" $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Set the non-root user as the default user

ENV APP_PATH=/app
RUN mkdir $APP_PATH && \
    chown $USERNAME:$USERNAME $APP_PATH

USER $USERNAME
WORKDIR $APP_PATH

COPY --chown=$USERNAME:$USERNAME ManageEngine_PMP_64bit.bin install_script.txt $APP_PATH
RUN chmod u+x ManageEngine_PMP_64bit.bin
RUN ./ManageEngine_PMP_64bit.bin -i silent -f /app/install_script.txt

CMD ["/app/PMP/bin/wrapper", "-c", "/app/PMP/conf/wrapper_lin.conf"]
