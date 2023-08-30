#!/bin/bash
set -x

PUML='java -jar /opt/plantuml.jar'
ARGS=${1}

FULL='${PUML} ${1}'

$FULL
