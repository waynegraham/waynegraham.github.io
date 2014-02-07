#! /usr/bin/env ruby

require 'jekyll-import'

JekyllImport::Importers::WordPress.run({
  "dbname"   => "db35371_liquidfoot",
  "user"     => "root",
  "password" => "root",
  "host"     => "localhost",
  "prefix"   => "wp_",
  "clean_entities" => true,
  "comments"       => true,
  "categories"     => true,
  "tags"           => true,
  "more_excerpt"   => true,
  "more_anchor"    => true,
  "status"         => ["publish"]
})

