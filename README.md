# Solutions Delivery Platform Documentation 

## Antora 

This repository contains documentation for the Solutions Delivery Platform (SDP)
that does not belong to any particular component of SDP. 

As such, it also serves as the [Antora](https://antora.org) playbook repository. 

## Building the Docs 

From the root of this repository, run ``make docs`` to build the documentation
locally.  Once finished, the static files will be in the ``docs`` directory. 

## Build Details

We make some custom modifications to Antora's site generation pipeline. 

``antora-lunr`` is used to enable the documentation's search functionality. 

This package hard-codes the query selector's used to find a page's headers. 

Given the changes that have been made for the UI Bundle, we had to customize 
the index generation process for lunr.  This can be found in ``resources/generator/lib``. 
