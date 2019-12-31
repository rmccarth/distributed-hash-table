# a more efficient way to lookup file locations in a distributed network of hosts

require 'digest'

class Ring
    def initialize (ringDictionary)
        @ringDictionary = ringDictionary
    end

    def getRing
        return @ringDictionary
    end

    def register (ip, port)
        @ip = ip
        @port = port
        hostname = @ip + @port
        uniqueID = Digest::SHA2.new(512).hexdigest hostname
        puts ("successfully created #{uniqueID[0...10]}!")
        puts "...registering"
        @ringDictionary[uniqueID] = @ringDictionary.size + 1
    end
end

ring = Ring.new({'host1':'abcd'})
puts ring.getRing

ring.register('10.10.10.10', '4444')
puts ring.getRing






