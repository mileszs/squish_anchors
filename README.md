# Squish Anchors

This is a lame little module that takes a bunch of adjacent anchor tags with the same href, such as

    <a href="/foo/bar"> This is</a>  <a href="/foo/bar">some mal </a> <a href="/foo/bar"> formed HTML content</a> from a JS wysiwig HTML editor

and turns it in to one big anchor tag, like

    <a href="/foo/bar"> This is some mal formed HTML content</a> from a JS wysiwig HTML editor 

## Usage:

    String.instance_eval { include SquishAnchors }
    ...
    bad = '<a href="/foo/bar"> This is</a>  <a href="/foo/bar">some mal </a> <a href="/foo/bar"> formed HTML content</a> from a JS wysiwig HTML editor'
    good = bad.squish_anchors
