// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract FadakaTokenV2 is Initializable, ERC20BurnableUpgradeable, PausableUpgradeable, AccessControlUpgradeable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    function initialize() public initializer {
        __ERC20_init("FadakaToken", "FDAK");
        __ERC20Burnable_init();
        __Pausable_init();
        __AccessControl_init();

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);

        _mint(msg.sender, 1_000_000_000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        override
    {
        super._beforeTokenTransfer(from, to, amount);
        require(!paused(), "Token transfer while paused");
    }

    function version() public pure returns (string memory) {
        return "Fadaka v2.1 - Burnable, Pausable, Role-based";
    }

   mapping (uint => string) public ipfsHashes;

function pinToIPFS(uint txId, string memory cid) public {
    ipfsHashes[txId] = cid;
   }

mapping(uint => string) public contentHash;

function attachData(uint tokenId, string memory cid) public {
    contentHash[tokenId] = cid;
  }
mapping(uint256 => string) public assistantCID;

function attachAssistantLog(uint256 tokenId, string memory cid) public {
    assistantCID[tokenId] = cid;
 }
}
