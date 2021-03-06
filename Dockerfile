FROM devtools/go-toolset-rhel7

ENV GOPATH "/opt/go"
ENV PATH "/opt/go/bin:$PATH"

USER root

RUN git clone https://github.com/gohugoio/hugo.git

RUN mkdir -p $GOPATH && scl enable go-toolset-1.12 "cd hugo && go install --tags extended && cd .. && rm -rf hugo /tmp/src/*"

ADD .s2i/bin /usr/local/s2i
LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i

USER 1001
EXPOSE 8080

CMD ["run"]
