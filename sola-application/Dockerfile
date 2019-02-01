FROM openjdk:8

WORKDIR /sola-glassfish
COPY ./ /sola-glassfish/
RUN chmod 755 /sola-glassfish/start-sola-app.sh

ENTRYPOINT ["/sola-glassfish/start-sola-app.sh"]
