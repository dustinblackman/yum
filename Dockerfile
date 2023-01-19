FROM fedora:36

RUN yum install -y createrepo rpm-sign

COPY ./rpmmacros /root/.rpmmacros
COPY ./create-repo.sh /usr/bin/

CMD ["/usr/bin/create-repo.sh"]
