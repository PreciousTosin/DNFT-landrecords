pragma solidity ^0.4.24;
/// @title DNFT Delegated Non-Fungible Token Standard

contract ERC994 {

	/// @dev checks if _child is a delegate of _parent.
	function isParent(uint256 _child, uint256 _parent) public view returns (bool);
	
	/// @dev gets the abstraction depth of _tokenId. 
	function getHeight(uint256 _tokenId) public view returns (uint256);
	
	/// @dev returns the fungible quantity balance of DNFT.
	function quantity(uint256 _tokenId) public view returns (uint256);
	
	/// @dev allows tokenholder to delegate new DNFT.
	function delegate(uint256 _tokenId, uint256 _writs, address _newowner) public;
	
	/// @dev allows owner to revoke a delegate NFT.
	function revoke(uint256 _tokenId, uint256 _delegate) public;

	/// @dev emitted whenever a new DNFT subdomain is delegated.
	event Delegate(uint256 _from, uint256 _tokenId, address indexed _owner);
	
	/// @dev emitted whenever an DNFT subdomain is revoked.
	event Revoke(uint256 _tokenId, uint256 _delegate);
}
