#***********************
#*Non-scalable Solution*
#***********************

#1) create a few peers, take their fake ip and port and hash to assign IDs
#2) create a fake file.
#3) hash the table and store it in its proper hash tabled based on the hash (id >=k)

require 'digest'

#define our test string

data = "made by rob"

#define our peers by IP address

A_CONST = '10.10.10.10'
B_CONST = '10.10.10.20'
C_CONST = '10.10.10.30'

#hash the IPs of nodes to create unique identifiers

node_A_address = Digest::SHA2.new(512).hexdigest A_CONST
node_B_address = Digest::SHA2.new(512).hexdigest B_CONST
node_C_address = Digest::SHA2.new(512).hexdigest C_CONST

#store the addresses in an array for iteration in assignDataToPeer

node_array = [node_A_address, node_B_address, node_C_address]
master_list = {node_A_address => "", node_B_address => "", node_C_address => ""}

#print some things to the screen for debugging

#print("peerA hash: ")
#puts(node_A_address)
#puts("")

#generate hashmap lookup table for each peer, so a host can search the
#files it is responsible for
#-------------------------------ACCESS SYNTAX--------------------#
#dictionary = { "one" => "eins", "two" => "zwei", "three" => "drei" }
#dictionary["zero"] = "null"
#puts dictionary["zero"]

$lookup_nodeA = {}
$lookup_nodeB = {}
$lookup_nodeC = {}

#data will be a string at first, we will make it a file later
def assignDataToPeer(data, master_list)
    #hash the string that comes in call it (k)
    dataHash = Digest::SHA2.new(512).hexdigest data
    print("storing file hash of: ")
    puts(dataHash[0...10])
    puts("")
    
    master_list.keys.each { |item|
        #compare the k value to each items hash/id, if less or equalto, store in master_list as the value.
        if(item.to_i >= dataHash.to_i)
            master_list[item] = dataHash
        end
    }
end

def searchForData(dataName, master_list)
    dataNameHash = Digest::SHA2.new(512).hexdigest dataName
    puts "Discoverying file with hash of: " + dataNameHash[0...10] + "\n\n"
    puts "HOSTS HOLDING THE FILE: " + "\n" + "#######################" + "\n"
    puts
    master_list.keys.each { |item|
        if (item.to_i >= dataNameHash.to_i)
            puts(item[0...10])
        end
    }
end

    
assignDataToPeer(data, master_list)
searchForData(data, master_list)

