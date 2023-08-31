# Image is based on the official PlantUML Docker Image
FROM plantuml/plantuml:1.2023

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]