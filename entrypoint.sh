#!/bin/bash

PUML='java -jar /opt/plantuml.jar'
ARGS=""

for arg in $@; do
  ARGS="${ARGS}@{arg}"
done

echo ${PUML} ${ARGS}
${PUML} ${ARGS}
