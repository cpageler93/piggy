# Piggy Cash

Support for OSX only

# Installation
## In Development
    ./install_and_run_example

## Later
    gem install piggycash

# CLI

## Setup
    piggycash setup

The ´setup´ command helps you to configure the database connection and initial database state with your first "account"

## Import
    piggycash import --file FILE --encoding ENCODING --seperator ';' --type TYPE

The ´import´ command parses your input files and imports booking entries into the database.

Currently there is a support for CSV Files from ING DiBa only.

## Validate
    piggycash validate saldo

# API

Serve API with:

    piggycash serve api
