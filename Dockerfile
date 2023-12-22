FROM fedora:39

RUN dnf install -y createrepo

COPY ./create-repo.sh /usr/bin/

CMD ["/usr/bin/create-repo.sh"]
