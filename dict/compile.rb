#!/usr/bin/env ruby
# encoding: utf-8

require 'pp'
require 'json'

words = nil
File.open("dutch.words", 'r:UTF-8') { |f| words = f.read.split("\n") }

rhymedict = {}

ends = words.map do |word|
  ending = word.gsub(/^.*[^aoeui]([aoeui])/, "\\1")
  rhymedict[ending] ||= []
  rhymedict[ending] << word
end

File.open("dutch.js", 'w') do |f|
  f.print("window.dictionary = ")
  JSON.dump(rhymedict, f)
end