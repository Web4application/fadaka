pragma solidity ^0.8.0;

contract Identity {
    // Mapping of user addresses to their digital ID
    mapping(address => uint256) public identities;
    
    bool private _nonReentrant = false; 
    
    modifier nonReentrant() {
        require(_nonReentrant == false, "Non-reentrancy guard triggered");
        
        _guardNonReentrant();
    }
    
    function registerIdentity()
        external
        nonReentrant()
        returns(bool success){
        
        // Perform IP verification (if required)
        if (_verifyIP()) return false;
        
        identities[msg.sender] = _generateUniqueID();
        emit IdentityRegistered(msg.sender);
    }

private

function  _guardNonReentrant() internal {
    require(_nonReentrant == false, "Non-reentrancy guard triggered");
    
   _nonReentrant= true;

}
