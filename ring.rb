# a more efficient way to lookup file locations in a distributed network of hosts

require 'digest'
require 'colorize'

class Node
    def name(ip, port)
        @ip = ip
        @port = port
        hostname = @ip + @port
        hostname = Digest::SHA2.new(512).hexdigest hostname #SHA2 512-hash to get a unique hostname and truncate to first 10 char
        puts "naming our node: " + hostname[0...10].green
        uniqueID = hostname[0...10]
    end
end


class Ring
    def initialize
        @ringDictionary = {}                             #create our empty dictionary to store pairs of uniqueID:nodeObject
    end
    def register(uniqueID, nodeObject)
        @uniqueID = uniqueID
        @nodeObject = nodeObject
        @ringDictionary[@uniqueID] = @nodeObject        #store the nodeObject at location "uniqueID"
    end
    
    def getNode(nodeID)
        @nodeID = nodeID
        puts(@ringDictionary[@nodeID])
    end
    
    attr_reader :ringDictionary
end



ring = Ring.new()
node = Node.new()
uniqueID = node.name("10.10.10.10", "1203")             #name our node


ring.register(uniqueID, node)                           # register our node with the ring
puts(ring.ringDictionary)

node = Node.new()
uniqueID = node.name("10.10.10.20", "4444")
ring.register(uniqueID, node)

ring.getNode(uniqueID)                                 #can now cal ring.getNode and provide it a uniqueID to retrieve a node object




