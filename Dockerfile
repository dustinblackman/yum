FROM fedora:37

RUN dnf install -y createrepo_c rpm-sign

COPY ./rpmmacros /root/.rpmmacros
COPY ./create-repo.sh /usr/bin/

CMD ["/usr/bin/create-repo.sh"]
