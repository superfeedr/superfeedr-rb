Superfeedr rb
=============

A ruby library based on Blather for Superfeedr.

This library is *very* opinionated. In fact there's really only one method `feed`.

Install
-------
Gem is hosted on [Gemcutter](http://gemcutter.org/)

    sudo gem install superfeedr-rb

Example
-------

    require 'rubygems'
    require 'superfeedr-rb'
    require 'pp'

    Superfeedr::Client.connect('demo@superfeedr.com', '*********').do |client
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
            :chunks => entry.chunks,
            :chunk => entry.chunk,
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
            }},
            :authors => entry.authors.map { |author| {
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
    end


Copyright
---------

Copyright (c) 2009 Jeff Smick. See LICENSE for details.
