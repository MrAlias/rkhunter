# rkhunter

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with rkhunter](#setup)
    * [What rkhunter affects](#what-rkhunter-affects)
    * [Beginning with rkhunter](#beginning-with-rkhunter)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

The rkhunter module enables management and configuration of the Unix-based tool, rkhunter, with puppet.

## Module Description

RKHunter (Rootkit Hunter) is a Unix-based tool that scans for rootkits, backdoors and possible local exploits. The rkhunter module allows you to manage the installation of the rkhunter pakage, configuration of how the tool is used, and managments automated usage of the tool.

## Setup

### What rkhunter affects

* Package files for rkhunter.
* Configuration files for rkhunter.


### Beginning with rkhunter

To get a basic setup of the rkhunter tool all you need is:

    include '::rkhunter'

This will get you a basic installation of the rkhunter package with default values.

## Usage

### Configuring RKHunter to not complain about its own configuration.

### Updating RKHunter when puppet updates a managed resource.

RKHunter will complain if puppet updates a file, directory, or package without updating its database.  The `rkhunter::propupd` type is used to manage this.  For instance, if you have puppet managing the `sudo` package you can update rkhunter whenever the package updates:

    package { 'sudo':
      ensure => latest,
    }
    
    rkhunter::propupd { 'sudo':
      packages  => 'sudo',
      subscribe => Package['sudo'],
    }

## Reference

### Class: rkhunter

### Resource: rkhunter::propupd

## Limitations

Currently rkhunter is only actively tested with the following operating systems:

* Debian 7.x
* CentOS 6.x
* Ubuntu 14.04
