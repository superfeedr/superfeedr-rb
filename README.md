Superfeedr rb
=============

A ruby library based on Blather for Superfeedr.

This library is *very* opinionated. In fact there's really only one method `feed`.
Setup the connection and 

Install
-------
Gem is hosted on [Gemcutter](http://gemcutter.org/)

    sudo gem install superfeedr-rb

Example
-------

    require 'rubygems'
    require 'superfeedr-rb'
    require 'pp'

    client = Superfeedr::Client.setup 'demo@superfeedr.com', '*********'

    client.feed('http://superfeedr.com/dummy.xml') do |status, entries|
      pp({
        :status => {
          :feed => status.feed,
          :code => status.code,
          :http => status.http,
          :next_fetch => status.next_fetch
        },
        :entries => entries.map { |entry| {
          :id => entry.id,
          :title => entry.title,
          :published => entry.published,
          :content => entry.content,
          :summary => entry.summary,
          :categories => entry.categories,
          :links => entry.links.map { |link| {
            :href => link.href,
            :rel => link.rel,
            :type => link.type,
            :title => link.title
          }}
          :authors => link.authors.map { |author| {
            :name => author.name,
            :email => author.email,
            :uri => author.uri
          }}
        }}
      })
    end

    client.feed('http://github.com/superfeedr.atom') do |notification|
      pp notification
    end

    EM.run { client.connect }


Copyright
---------

Copyright (c) 2009 Jeff Smick. See LICENSE for details.
