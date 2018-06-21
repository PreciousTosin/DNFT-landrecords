pragma solidity ^0.4.24;

import "./DNFT.sol";
import "./zeppelin/lifecycle/Killable.sol";

contract Zone is Killable, DNFT {

	address public ZoneAuthority;

	// Ordinates are contracts which own DNFTs and have more complex management and conditionals.
	// Example ordinates are options and quobands.
	// tokenId => Ordinate Address
	mapping(uint256 => address) private ordinates;
	mapping(address => bool) private zones;

	event ZoneCreation(
		address indexed zone, 
		address indexed owner, 
		uint writ,
		uint balance
	);

	constructor(uint _tokenId, uint _writ, string _metadata, uint _balance, address _owner) public {
		owner = msg.sender;
		makeNewDNFT(_tokenId, _writ, _metadata, _balance, _owner);
	}
	
	/**
	* @dev creats a new zone (root DNFT) at the root level
	* @param _writ fungible amount of space (meter-square) that a DNFT will have 
	* @param _metadata link to more information about the DNFT outside the blockchain
	* @param _balance balance of writ space left after delegation, the values of _writ 
	*           and _balance are equal at root zone (DNFT) creation
	* @param _owner address of the zone controller (private wallet or ordinate contract)
	*/
	function makeNewDNFT(uint _tokenId, uint _writ, string _metadata, uint _balance, address _owner)
		public
	{
		require(owner == msg.sender);
		require(_writ < _balance);
		// address newzone = new DNFT(_writ, _metadata, _owner);
		address newzone = new DNFT(_tokenId, _writ, _metadata, _owner);

		require(newzone != address(0));
		zones[newzone] = true;

		emit ZoneCreation(newzone, _owner, _writ, _balance);
	}

	function newOrdinate() {}
}
