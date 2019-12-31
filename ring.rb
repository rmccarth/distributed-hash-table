# a more efficient way to lookup file locations in a distributed network of hosts


class Dog
    def initialize(breed, name)
        @breed = breed
        @name = name
    end

    def bark
        puts 'Ruff! grrr!'
    end

    def display
        puts "I am a dog of #{@breed} and my name is #{@name}"
    end
end

dog = Dog.new('bulldog', 'Xena')

dog.bark
dog.display

=begin
this is how you do a block comment in ruby
=end

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






