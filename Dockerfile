FROM python:3.11

COPY ./requirements.txt /tmp/

RUN apt-get update && \
    apt-get install rsync -y && \
    pip3 install --no-cache-dir -r /tmp/requirements.txt && \
    sed -i \
        -e "/stop_signal:/a \ \ \ \ \ \ \ \ entrypoint: \"{{ item.entrypoint | default\(omit\) }}\"" \
        /usr/local/lib/python3.11/site-packages/molecule_plugins/docker/playbooks/create.yml && \
    apt-get install docker.io -y

WORKDIR /root/workstation
