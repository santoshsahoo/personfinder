#!/bin/bash

# Scripts in the tools/ directory should source this file with the line:
# pushd "$(dirname $0)" >/dev/null && source common.sh && popd >/dev/null

export TOOLS_DIR=$(pwd)
export PROJECT_DIR=$(dirname $TOOLS_DIR)
export APP_DIR=$PROJECT_DIR/app
export TESTS_DIR=$PROJECT_DIR/tests

for dir in \
    "$APPENGINE_DIR" \
    /usr/lib/google_appengine \
    /usr/local/lib/google_appengine \
    /usr/local/google_appengine \
    $HOME/google_appengine; do
    if [ -d "$dir" ]; then
        export APPENGINE_DIR="$dir"
        break
    fi
done

if [ -z "$APPENGINE_DIR" ]; then
    echo "Could not find google_appengine directory.  Please set APPENGINE_DIR."
    exit 1
fi

for python in \
    "$PYTHON" \
    $(which python2.5) \
    /usr/local/bin/python2.5 \
    /usr/bin/python2.5 \
    /Library/Frameworks/Python.framework/Versions/2.5/bin/python; do
    if [ -x "$python" ]; then
        export PYTHON="$python"
        break
    fi
done

if [ -z "$PYTHON" ]; then
    DEFAULT_PYTHON=$(which python)
    if [[ "$($DEFAULT_PYTHON -V 2>&1)" =~ "Python 2.5" ]]; then
        export PYTHON="$DEFAULT_PYTHON"
    fi
fi

if [ -z "$PYTHON" ]; then
    echo "Could not find python2.5 executable.  Please set PYTHON."
    exit 1
fi

export PYTHONPATH=\
"$APP_DIR":\
"$TESTS_DIR":\
"$TOOLS_DIR":\
"$APPENGINE_DIR":\
"$APPENGINE_DIR/lib/fancy_urllib":\
"$APPENGINE_DIR/lib/webob":\
"$APPENGINE_DIR/lib/webob_0_9":\
"$APPENGINE_DIR/lib/yaml/lib":\
"$APPENGINE_DIR/lib/django_1_2"

if [ -z "$USER_EMAIL" ]; then
    export USER_EMAIL=$(whoami)@google.com
fi
