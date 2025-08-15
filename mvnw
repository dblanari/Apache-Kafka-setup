#!/bin/sh
set -e
DIR="$(cd "$(dirname "$0")"; pwd)"
WRAPPER_DIR="$DIR/.mvn/wrapper"
WRAPPER_JAR="$WRAPPER_DIR/maven-wrapper.jar"
PROPS="$WRAPPER_DIR/maven-wrapper.properties"

# Download wrapper jar if missing
if [ ! -f "$WRAPPER_JAR" ]; then
  if command -v curl >/dev/null 2>&1; then
    WRAPPER_URL=$(grep -E '^wrapperUrl=' "$PROPS" | cut -d= -f2-)
    mkdir -p "$WRAPPER_DIR"
    curl -fsSL "$WRAPPER_URL" -o "$WRAPPER_JAR" || { echo "Failed to download Maven wrapper" >&2; exit 1; }
  else
    echo "curl is required to download Maven wrapper" >&2
    exit 1
  fi
fi

JAVA_CMD="java"
[ -n "$JAVA_HOME" ] && JAVA_CMD="$JAVA_HOME/bin/java"
exec "$JAVA_CMD" -jar "$WRAPPER_JAR" "$@"
