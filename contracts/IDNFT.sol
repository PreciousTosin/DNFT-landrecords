pragma solidity ^0.4.24;

contract IDNFT {
  function getMetadata(uint _tokenId) public view returns(string _uri);
  function totalSupply() public view returns (uint256);
  function balanceOf(address _owner) public view returns (uint256);
  function inventoryOf(address _owner) public view returns (uint256[]);
  function isParent(uint256 _child, uint256 _parent) public view returns (bool);
  function ownerOf(uint256 _tokenId) public view returns (address _ownerOf);
  function approvedFor(uint256 _tokenId) public view returns (address);
  function delegatedFrom(uint256 _delegate, uint256 _tokenId) public view returns (bool _delegatedFrom);
  function available(uint _tokenId) public view returns (uint256 _writs);
  function getHeight(uint _tokenId) public view returns (uint256 _height);
  function transfer(address _to, uint256 _tokenId) public;
  function approve(address _to, uint256 _tokenId) public;
  function transferFrom(uint256 _tokenId) public;
  function setMetadata(uint256 _tokenId, string _metadata) public;
  function delegate(uint256 _tokenId, uint256 _writs, address _newowner) public;
  function revoke(uint256 _tokenId, uint256 _delegate) public;
}
