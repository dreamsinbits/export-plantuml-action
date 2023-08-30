#!/bin/bash
set -x

PUML='java -jar /opt/plantuml.jar -svg -o out diagrams/*.puml'
ARGS=$1

echo $1

$PUML 
