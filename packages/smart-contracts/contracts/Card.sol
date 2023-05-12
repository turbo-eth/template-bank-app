//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import { ERC20TWAB } from "./PoolTogether/ERC20TWAB.sol";
import { ISVGRender } from "./ERC721K/interfaces/ISVGRender.sol";
import { ERC721K } from "./ERC721K/ERC721K.sol";
import { ERC721Storage } from "./ERC721K/ERC721Storage.sol";
import { CardStorage } from "./CardStorage.sol";

contract Card is ERC721K {
  uint256 private immutable CONTROLLER_ROLE = 1e18;

  mapping(address => uint256) private _belongsTo;

  constructor(
    string memory name,
    string memory symbol,
    address erc721Storage
  ) ERC721K(name, symbol, erc721Storage) {
    _idCounter++;
  }

  /* ===================================================================================== */
  /* Override Functions                                                                    */
  /* ===================================================================================== */

  function supportsInterface(bytes4 interfaceId)
    public
    view
    virtual
    override(ERC721K)
    returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }

  function ownerOf(uint256 tokenId) public view virtual override returns (address) {
    address owner = _ownerOf[tokenId];
    if (owner == address(0)) {
      return address(0);
    }
    return owner;
  }

  function belongsTo(address account) public view virtual returns (uint256) {
    return _belongsTo[account];
  }

  /* ===================================================================================== */
  /* External Functions                                                                    */
  /* ===================================================================================== */

  // --------------------------------------
  // READS
  // --------------------------------------

  function preview(address account) external view returns (string memory) {
    bytes memory imageBytes = CardStorage(_erc721Storage).getPreview(account);
    return ISVGRender(ERC721Storage(_erc721Storage).getERC721KRender()).render(imageBytes);
  }

  function previewWithStyle(
    address account,
    uint8 color,
    uint8 emoji
  ) external view returns (string memory) {
    bytes memory imageBytes = CardStorage(_erc721Storage).getPreviewWithStyle(
      account,
      color,
      emoji
    );
    return ISVGRender(ERC721Storage(_erc721Storage).getERC72KTraits()).render(imageBytes);
  }

  // --------------------------------------
  // WRITES
  // --------------------------------------

  /**
   * @notice Mints a new token to the given address
   * @param to address - Address to mint to`
   */
  function mint(address to) external returns (uint256) {
    require(hasAllRoles(msg.sender, CONTROLLER_ROLE), "Web3Card:unauthorized");
    require(_belongsTo[to] == 0, "Web3Card:activated");
    uint256 nextId;
    unchecked {
      nextId = _idCounter++;
      _belongsTo[to] = nextId;
      _mint(to, nextId);
    }
    return nextId;
  }

  /**
   * @notice Burns a token
   * @param tokenId uint256 - Token ID to burn
   */
  function burn(uint256 tokenId) external {
    require(hasAllRoles(msg.sender, CONTROLLER_ROLE), "Web3Card:unauthorized");
    address owner = ownerOf(tokenId);
    _belongsTo[owner] = 0;
    _burn(tokenId);
  }

  function transferFrom(
    address from,
    address to,
    uint256 tokenId
  ) public virtual override {
    _belongsTo[from] = 0;
    _belongsTo[to] = tokenId;
    super.transferFrom(from, to, tokenId);
  }

  function safeTransferFrom(
    address from,
    address to,
    uint256 tokenId
  ) public virtual override {
    _belongsTo[from] = 0;
    _belongsTo[to] = tokenId;
    super.safeTransferFrom(from, to, tokenId);
  }

  function safeTransferFrom(
    address from,
    address to,
    uint256 tokenId,
    bytes calldata data
  ) public virtual override {
    _belongsTo[from] = 0;
    _belongsTo[to] = tokenId;
    super.safeTransferFrom(from, to, tokenId, data);
  }

  /* ===================================================================================== */
  /* Internal Functions                                                                    */
  /* ===================================================================================== */

  function _tokenData(uint256 _tokenId)
    internal
    view
    virtual
    override
    returns (bytes memory, bytes memory)
  {
    bytes memory imageBytes = CardStorage(_erc721Storage).getImageBytes(_tokenId);
    bytes memory traitsBytes = CardStorage(_erc721Storage).getTraitsBytes(_tokenId);
    return (imageBytes, traitsBytes);
  }
}
