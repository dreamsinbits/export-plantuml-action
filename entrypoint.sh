#!/bin/bash
set -x

PUML='java -jar /opt/plantuml.jar'
ARGS=$1

echo $1

$PUML $1
