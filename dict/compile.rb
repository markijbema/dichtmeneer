#!/usr/bin/env ruby
# encoding: utf-8

require 'pp'
require 'json'

words = nil
File.open("dutch.words", 'r:UTF-8') { |f| words = f.read.split("\n") }

rhymedict = {}


ends = words.map do |word|
  ending = word.gsub(/^.*?([aoeui]+[^aoeui]*(?:|ie|ige|ig|el|ers|eren|ere|eerden|eerde|heid|es|ingen|ing|er|e|en))$/, "\\1")
  rhymedict[ending] ||= []
  rhymedict[ending] << word
end

File.open("../app/js/dutch.js", 'w') do |f|
  f.print("window.dictionary = ")
  JSON.dump(rhymedict, f)
end

foo = rhymedict.map do |k,v|
  [k, v.size]
end.sort {|a, b| a[1] <=> b[1] }
pp foo