// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

import { Owned } from "./Solbase/Owned.sol";
import { LibString } from "./Solbase/LibString.sol";
import { IStream } from "./ERC721K/interfaces/IStream.sol";
import { ITraitsFetch } from "./ERC721K/interfaces/ITraitsFetch.sol";

/**
 * @title CardTraits
 * @author Kames Geraghty
 */
contract CardTraits is ITraitsFetch, Owned {
  constructor() Owned(msg.sender) {}


  /* ===================================================================================== */
  /* External Functions                                                                    */
  /* ===================================================================================== */

  function fetch(bytes memory input) external view returns (string memory) {
    (
      address account,
      address asset,
      uint256 balance,
      uint256 chance,
      uint256 avgBalance2Weeks,
      uint256 avgBalance8Weeks,
      uint256 avgBalance26Weeks,
      uint256 avgBalance52Weeks,
      string memory emoji,
      bytes32 color
    ) = abi.decode(
        input,
        (address, address, uint256, uint256, uint256, uint256, uint256, uint256, string, bytes32)
      );

    string memory _account = LibString.toHexString(uint256(uint160(account)), 20);
    string memory _asset = LibString.toHexString(uint256(uint160(asset)), 20);

    return
      string.concat(
        _generateTrait("owner", _account),
        ",",
        _generateTrait("asset", _asset),
        ",",
        _generateTrait("balance", LibString.toString(balance)),
        ",",
        _generateTrait("chance", LibString.toString(chance)),
        ",",
        _generateTrait("avgBalance2Weeks", LibString.toString(avgBalance2Weeks)),
        ",",
        _generateTrait("avgBalance8Weeks", LibString.toString(avgBalance8Weeks)),
        ",",
        _generateTrait("avgBalance26Weeks", LibString.toString(avgBalance26Weeks)),
        ",",
        _generateTrait("avgBalance52Weeks", LibString.toString(avgBalance52Weeks)),
        ",",
        _generateTrait("emoji", emoji)
      );
  }

  /* ===================================================================================== */
  /* Internal Functions                                                                    */
  /* ===================================================================================== */

  function _generateTrait(string memory _key, string memory _value)
    internal
    pure
    returns (string memory __traits)
  {
    return string.concat('{"trait_type":' '"', _key, '",', '"value":', '"', _value, '"}');
  }

  function _generateTraits(string[] memory _keys, string[] memory _values)
    internal
    pure
    returns (string memory __traits)
  {
    string memory _traits = "";
    for (uint256 i = 0; i < _keys.length; i++) {
      if (bytes(_values[i]).length > 0) {
        _traits = string.concat(_traits, _generateTrait(_keys[i], _values[i]), ",");
      }
    }
    return _traits;
  }
}
