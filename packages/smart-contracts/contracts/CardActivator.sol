//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import { Owned } from "./Solbase/Owned.sol";
import { Card } from "./Card.sol";
import { CardDesign } from "./CardDesign.sol";

contract CardActivator is Owned {
  address public erc721KInstance;
  address public erc721KDesignInstance;

  uint256 private STYLE_UPGRADE_VALUE = 0.01 ether;

  constructor(
    address admin,
    address _erc721KInstance,
    address _erc721KDesignInstance
  ) Owned(admin) {
    erc721KInstance = _erc721KInstance;
    erc721KDesignInstance = _erc721KDesignInstance;
  }

  function activate(address to) external {
    Card(erc721KInstance).mint(to);
  }

  function activateWithStyle(
    address to,
    uint8 color,
    uint8 emoji
  ) external payable {
    if (color + emoji >= 1)
      require(msg.value >= STYLE_UPGRADE_VALUE, "Web3CardActivator:insufficient-eth");
    uint256 tokenId_ = Card(erc721KInstance).mint(to);
    CardDesign(erc721KDesignInstance).setDuringMint(tokenId_, color, emoji);
  }

  function release(uint256 value) external onlyOwner {
    (bool _success, ) = msg.sender.call{ value: value }("");
    require(_success, "Web3CardActivator:eth-release-failed");
  }

  function setStyleUpgradeCost(uint256 value) external onlyOwner {
    STYLE_UPGRADE_VALUE = value;
  }
}
