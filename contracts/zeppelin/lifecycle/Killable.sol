pragma solidity ^0.4.22; // solhint-disable-line


import "./../ownership/Ownable.sol";


/*
 * Killable
 * Base contract that can be killed by owner. All funds in contract will be sent to the owner.
 */
contract Killable is Ownable {
    function kill() private onlyOwner {
        selfdestruct(owner);
    }
}
