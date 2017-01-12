# Piggy Cash

Support for OSX only

# Installation
## In Development
    ./install_and_run_example

## Later
    gem install piggycash

# Entities

## Account

Represents a banking account

**Main Properties:**
* name
* iban

## BookingEntry

Represents a booking entry for one account

**Main Properties:**
* booking_date
* valuta
* participant
* booking_type
* usage
* value
* saldo

**Checksum:**

There is a checksum attribute for each booking entry for quick checks of uniqueness

## BookingEntryQuery

Query for booking entries.

**Main Properties:**
* name
* query

**Query:**

Query is just a MySQL where condition for the table ``booking_entries as be``
So you can type ``be.participant like "%DIGITALOCEAN%"``

## BookingEntryTagRecognizer

Assign tags to booking entries, queried by a ``BookingEntryQuery`

**Main Properties:**
* booking_entry_query_id
* tag_id

## EvaluatedBookingEntry

**Basic:** just a copy of BookingEntry

**Advanced:**
A booking entry will be transfered to an evaluated booking entry at creation time. Since the booking entry represents the 100% original version of your balance, we dont want to modify it.

An evaluated booking entry can be assigned to tags and can be splitted.

**Split:**

You paid 70€ in a supermarket for food and detergents.
You can split your evaluated booking entry into two pieces referencing to the same original booking entry.

Lets say you paid 17,50€ for the detergents and 52,50€ for food:
**BookingEntry 1** -> name: "detergents at mycoolsupermarket", tags: mycoolsupermarket, detergents, total_value: 70,00€, split: 0.25
**BookingEntry 2** -> name: "food at mycoolsupermarket", tags: mycoolsupermarket, food, total_value: 70,00€, split: 0,75

## Tag

Tag

**Main Properties:**
* name

# CLI

## Setup

**Initial setup**

* database connection
* database migration / create
 first account

    setup


## API

### Serve

serves REST API at given port

    piggycash api serve --port 1234

## Import

    piggycash import --file ~/path/to/file.csv --encoding ISO-8859-1 --seperator ';' --type ingdiba

## Query
    piggycash query assign tags

## Tags

### Recognize

    piggycash tags recognize

### Reveal untagged

    piggycash tags reveal untagged

## Validate

    piggycash validate saldo

  GLOBAL OPTIONS:
        
    --verbose 
        
        
    --debug 
        
        
    --force 
        
        
    -h, --help 
        Display help documentation
        
    -v, --version 
        Display version information
