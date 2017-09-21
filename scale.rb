#!/usr/bin/ruby

require_relative "tonic"

def usage()
    puts %{\
usage: ./scale.rb tonic
  C for C major
  a for A minor
  F# for F sharp major
  eb for E flat minor}
end

if ARGV.length != 1
    usage()
    exit(2)
end

t = new Tonic(ARGV[0])
if t.error
    usage()
    exit(2)
end
p t.scale
