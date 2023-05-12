// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import { ERC721 } from "./Solbase/ERC721.sol";
import { OwnedThreeStep } from "./Solbase/OwnedThreeStep.sol";

contract CardDesign is OwnedThreeStep {
  address public erc721KActivatorInstance;

  uint256 private STYLE_UPGRADE_VALUE = 0.01 ether;

  mapping(uint256 => uint8) private _color;
  mapping(uint256 => uint8) private _emoji;

  mapping(uint8 => bytes) private _colorMap;
  mapping(uint8 => string) private _emojiMap;

  mapping(address => bool) private _supporter;

  /* ===================================================================================== */
  /* Constructor & Modifiers                                                               */
  /* ===================================================================================== */

  constructor(address _owner) OwnedThreeStep(_owner) {
    _colorMap[0] = hex"6236C5"; // Purple
    _colorMap[1] = hex"224396"; // Blue
    _colorMap[2] = hex"922B2B"; // Red
    _colorMap[3] = hex"498933"; // Green
    _colorMap[4] = hex"313131"; // Black

    _emojiMap[0] = unicode"🏦";
    _emojiMap[1] = unicode"🦜";
    _emojiMap[2] = unicode"🦊";
    _emojiMap[3] = unicode"🦄";
    _emojiMap[4] = unicode"🐙";
    _emojiMap[5] = unicode"🐵";
    _emojiMap[6] = unicode"🐳";
    _emojiMap[7] = unicode"🐝";
    _emojiMap[8] = unicode"🐺";
    _emojiMap[9] = unicode"👑";
    _emojiMap[10] = unicode"🚀";
    _emojiMap[11] = unicode"🌈";
    _emojiMap[12] = unicode"🪶";
    _emojiMap[13] = unicode"🧸";
    _emojiMap[14] = unicode"🎁";
    _emojiMap[15] = unicode"💌";
    _emojiMap[16] = unicode"🎀";
    _emojiMap[17] = unicode"🔮";
    _emojiMap[18] = unicode"💎";
    _emojiMap[19] = unicode"🪅";
    _emojiMap[20] = unicode"🏗";
    _emojiMap[21] = unicode"🧰";
    _emojiMap[22] = unicode"🧲";
    _emojiMap[23] = unicode"🧪";
    _emojiMap[24] = unicode"🛡️";
    _emojiMap[25] = unicode"🧬";
    _emojiMap[26] = unicode"🧭";
    _emojiMap[27] = unicode"🧮";
    _emojiMap[28] = unicode"⚔️";
    _emojiMap[29] = unicode"🧰";
    _emojiMap[30] = unicode"🧱";
    _emojiMap[31] = unicode"⛓️";
    _emojiMap[32] = unicode"🏈";
    _emojiMap[33] = unicode"🏀";
    _emojiMap[34] = unicode"⚽️";
    _emojiMap[35] = unicode"🏐";
    _emojiMap[36] = unicode"🏓";
    _emojiMap[37] = unicode"🎾";
    _emojiMap[38] = unicode"🎲";
    _emojiMap[39] = unicode"🏉";
    _emojiMap[40] = unicode"🎽";
    _emojiMap[41] = unicode"🏆";
    _emojiMap[42] = unicode"🎯";
  }

  /* ===================================================================================== */
  /* External Functions                                                                    */
  /* ===================================================================================== */

  function getEmoji(uint256 tokenId) external view returns (string memory) {
    return _emojiMap[_emoji[tokenId]];
  }

  function getColor(uint256 tokenId) external view returns (bytes memory) {
    return _colorMap[_color[tokenId]];
  }

  function getEmojiFromMap(uint8 emojiId) external view returns (string memory) {
    return _emojiMap[emojiId];
  }

  function getColorFromMap(uint8 colorId) external view returns (bytes memory) {
    return _colorMap[colorId];
  }

  function setDuringMint(
    uint256 tokenId,
    uint8 color,
    uint8 emoji
  ) external {
    require(msg.sender == erc721KActivatorInstance, "Web3CardDesign:not-authorized");
    _color[tokenId] = color;
    _emoji[tokenId] = emoji;
  }

  function setEmoji(uint256 tokenId, uint8 emoji) external payable {
    require(msg.value >= STYLE_UPGRADE_VALUE, "Web3CardDesign:insufficient-eth");
    require(
      msg.sender == ERC721(erc721KActivatorInstance).ownerOf(tokenId),
      "Web3CardDesign:not-owner"
    );
    _emoji[tokenId] = emoji;
    _call(msg.value);
  }

  function setColor(uint256 tokenId, uint8 color) external payable {
    require(msg.value >= STYLE_UPGRADE_VALUE, "Web3CardDesign:insufficient-eth");
    require(
      msg.sender == ERC721(erc721KActivatorInstance).ownerOf(tokenId),
      "Web3CardDesign:not-owner"
    );
    _color[tokenId] = color;
    _call(msg.value);
  }

  function setERC721KActivatorInstance(address _erc721KActivatorInstance) external onlyOwner {
    erc721KActivatorInstance = _erc721KActivatorInstance;
  }

  function setStyleUpgradeCost(uint256 _styleUpgradeCost) external onlyOwner {
    STYLE_UPGRADE_VALUE = _styleUpgradeCost;
  }

  function _call(uint256 value) internal {
    (bool _success, ) = erc721KActivatorInstance.call{ value: value }("");
    require(_success, "Web3CardDesign:call-failed");
  }
}
