pragma solidity ^0.4.22; // solhint-disable-line

import "./zeppelin/lifecycle/Killable.sol";
// import "./library/StringUtils.sol";


contract User is Killable {

    mapping(address => uint) private addressToIndex;
    mapping(bytes16 => uint) private usernameToIndex;
    address[] private addresses;
    bytes16[] private usernames;
    bytes[] private ipfsHashes;

    constructor() public {
        // mappings are virtually initialized to zero values so we need to "waste" 
        // the first element of the arrays
        // instead of wasting it we use it to create a user for the contract itself
        addresses.push(msg.sender);
        usernames.push("self");
        ipfsHashes.push("not-available");
    }

    function hasUser(address userAddress) public view returns(bool hasIndeed) {
        return (addressToIndex[userAddress] > 0 || userAddress == addresses[0]);
    }

    function usernameTaken(bytes16 username) public view returns(bool takenIndeed) {
        return (usernameToIndex[username] > 0 || username == "self");
    }

    function createUser(bytes16 username, bytes ipfsHash) public returns(bool success) {
        require(!hasUser(msg.sender));
        require(!usernameTaken(username));
        addresses.push(msg.sender);
        usernames.push(username);
        ipfsHashes.push(ipfsHash);
        addressToIndex[msg.sender] = addresses.length - 1;
        usernameToIndex[username] = addresses.length - 1;

        return true;
    }

    function updateUser(bytes ipfsHash) public returns(bool success) {
        require(hasUser(msg.sender));

        ipfsHashes[addressToIndex[msg.sender]] = ipfsHash;
        return true;
    }

    function getUserCount() public view returns (uint count) {
        return addresses.length;
    }

    // get by index
    function getUserByIndex(uint index)
        public
        view
        returns (address userAddress, bytes16 username, bytes ipfsHash)
    {
        require(index < addresses.length, "Invalid Index Value");
        return(addresses[index], usernames[index], ipfsHashes[index]);
    }

    function getAddressByIndex(uint index) public view returns(address userAddress) {
        require(index < addresses.length, "Invalid Index Value");
        return addresses[index];
    }

    function getUsernameByIndex(uint index) public view returns(bytes16 username) {
        require(index < addresses.length, "Invalid Index Value");
        return usernames[index];
    }

    function getIpfsHashByIndex(uint index) public view returns(bytes ipfsHash) {
        require(index < addresses.length, "Invalid Index Value");
        return ipfsHashes[index];
    }

    // get by address
    function getUserByAddress(address userAddress) 
        public 
        view 
        returns (uint index, bytes16 username, bytes ipfsHash) 
    {
        require(index < addresses.length);
        if (hasUser(userAddress) == true) {
            return (
                addressToIndex[userAddress],
                usernames[addressToIndex[userAddress]],
                ipfsHashes[addressToIndex[userAddress]]
            );
        } else revert("User does not exist");
    }

    function getIndexByAddress(address userAddress) public view returns(uint index) {
        require(hasUser(userAddress), "Index does not exist");
        return addressToIndex[userAddress];
    }

    function getUsernameByAddress(address userAddress) public view returns(bytes16 username) {
        require(hasUser(userAddress), "User does not exist");
        return usernames[addressToIndex[userAddress]];
    }

    function getIpfsHashByAddress(address userAddress) public view returns(bytes ipfsHash) {
        require(hasUser(userAddress), "Ipfs Hash does not exist");
        return ipfsHashes[addressToIndex[userAddress]];
    }

    // get by username
    function getUserByUsername(bytes16 username) 
        public 
        view 
        returns (uint index, address userAddress, bytes ipfsHash) 
    {
        require(index < addresses.length);
        if (usernameTaken(username) == true) {
            return(
                usernameToIndex[username], 
                addresses[usernameToIndex[username]], 
                ipfsHashes[usernameToIndex[username]]
            );
        } else revert("User does not exist");
    }

    function getIndexByUsername(bytes16 username) public view returns(uint index) {
        require(usernameTaken(username), "Index does not exist");
        return usernameToIndex[username];
    }

    function getAddressByUsername(bytes16 username) public view returns(address userAddress) {
        require(usernameTaken(username), "Address not found");
        return addresses[usernameToIndex[username]];
    }

    function getIpfsHashByUsername(bytes16 username) public view returns(bytes ipfsHash) {
        require(usernameTaken(username), "Ipfs Hash not found");
        return ipfsHashes[usernameToIndex[username]];
    }
}

