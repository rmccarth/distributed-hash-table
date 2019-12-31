# a more efficient way to lookup file locations in a distributed network of hosts

require 'digest'
require 'colorize'

class Ring
    def initialize (ringDictionary)
        @ringDictionary = ringDictionary
    end

    def getRing
        return @ringDictionary
    end

    def register (ip, port)
        begin
            @ip = ip
            @port = port
            puts "#{@ip} signaled for registation at port: #{@port}".blue
            hostname = @ip + @port
            uniqueID = Digest::SHA2.new(512).hexdigest hostname
            puts ("successfully created hostname #{uniqueID[0...10]}!").green
            puts "...registering"
            truncated_uniqueID = uniqueID[0...10]
            puts "*** registered #{truncated_uniqueID} ***".green
            puts "assigning the host a place on the ring".blue
            @ringDictionary[truncated_uniqueID] = @ringDictionary.size + 1
        end
        rescue
            puts "failure to register with the ring, exiting".red 
            raise
        end
    end

ring = Ring.new({'host1':'abcd'})
puts ring.getRing

ring.register('10.10.10.10', '4444')
puts ring.getRing






