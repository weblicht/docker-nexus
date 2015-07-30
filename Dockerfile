FROM sonatype/nexus:oss

USER root


RUN yum install -y unzip \
 yum clean all

ENV SONATYPE_WORK /sonatype-work

#install nexus-apt-repository-plugin
RUN curl --fail --silent --location --retry 3 \
    -o /tmp/nexus-apt-plugin-1.0.2-bundle.zip \
    https://github.com/inventage/nexus-apt-plugin/releases/download/nexus-apt-plugin-1.0.2/nexus-apt-plugin-1.0.2-bundle.zip \
    && unzip -d /opt/sonatype/nexus/nexus/WEB-INF/plugin-repository \
    /tmp/nexus-apt-plugin-1.0.2-bundle.zip \
    && find /opt/sonatype/nexus/nexus/WEB-INF/plugin-repository/nexus-apt-plugin-1.0.2 \
    -type d -exec chmod 755 {} \; \
    && find /opt/sonatype/nexus/nexus/WEB-INF/plugin-repository/nexus-apt-plugin-1.0.2 \
    -type f -exec chmod 644 {} \; \
    && rm /tmp/nexus-apt-plugin-1.0.2-bundle.zip

USER nexus

