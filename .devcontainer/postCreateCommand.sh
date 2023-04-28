#!/bin/sh
pip3 install --upgrade --user -r requirements.txt \
    && ansible-galaxy install -r requirements.yml