FROM centos:7.4.1708
COPY group_dnsoarc-dnsperf-epel-7.repo /etc/yum.repos.d
COPY start.sh /
COPY example10m.txt /
COPY example2k.txt /
RUN yum install -y dnsperf
CMD ["/start.sh"]
