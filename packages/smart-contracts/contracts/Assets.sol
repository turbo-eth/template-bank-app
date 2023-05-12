// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import { OwnedThreeStep } from "./Solbase/OwnedThreeStep.sol";

contract Web3Assets is OwnedThreeStep {
  mapping(bytes32 => string) private assets;

  /* ===================================================================================== */
  /* Constructor & Modifiers                                                               */
  /* ===================================================================================== */

  constructor(address _owner) OwnedThreeStep(_owner) {}

  /* ===================================================================================== */
  /* External Functions                                                                    */
  /* ===================================================================================== */

  function get(bytes32 position) external view returns (string memory) {
    return assets[position];
  }

  function decode(bytes memory input) external view returns (string memory) {
    bytes32 position = abi.decode(input, (bytes32));
    return assets[position];
  }

  function set(bytes32 position, string memory svg) external onlyOwner {
    assets[position] = svg;
  }
}
