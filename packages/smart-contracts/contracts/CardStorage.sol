pragma solidity 0.8.15;

import { Strings } from "@openzeppelin/contracts/utils/Strings.sol";
import { ERC721Storage } from "./ERC721K/ERC721Storage.sol";
import { ERC721 } from "./Solbase/ERC721.sol";
import { TwabLib } from "./PoolTogether/twab/TwabLib.sol";
import { ERC20TWAB } from "./PoolTogether/ERC20TWAB.sol";
import { CardDesign } from "./CardDesign.sol";

/*
 * @title CardStorage
 * @author Kames Geraghty
 * @description CardStorge provides storage and rendering instriutions for the Card contract.
 */
contract CardStorage is ERC721Storage {
  address public assetUnderlying;

  /// Smart Contact Instance(s)
  address public erc20TWABInstance;
  address public erc721KInstance;
  address public erc721KDesignInstance;

  bytes private DEFAULT_COLOR = hex"6236C5";

  mapping(uint256 => string) private _name;
  mapping(uint256 => string) private _emojiMap;

  constructor(
    address _svgRender_,
    address _traitsFetch_,
    ContractURI memory _contractURI_,
    address _erc20TWABInstance,
    address _erc721KDesignInstance,
    address _assetUnderlying
  ) ERC721Storage(_svgRender_, _traitsFetch_, _contractURI_) {
    erc20TWABInstance = _erc20TWABInstance;
    erc721KDesignInstance = _erc721KDesignInstance;
    assetUnderlying = _assetUnderlying;
  }

  struct RenderMetadata {
    uint256 balance;
    uint256 chance;
    uint256 avgBalance2Weeks;
    uint256 avgBalance8Weeks;
    uint256 avgBalance26Weeks;
    uint256 avgBalance52Weeks;
    string emoji;
    bytes color;
  }

  /// =====================================================================================
  /// Override Functions
  /// =====================================================================================
  function _parseName(uint256 _tokenId) internal view override returns (string memory) {
    return string.concat("Web3 Savings Card #", Strings.toString(_tokenId));
  }

  function _parseDescription(uint256 _tokenId) internal view override returns (string memory) {
    return "Member of the Web3 Savings Network";
  }

  /// =====================================================================================
  /// External Functions
  /// =====================================================================================

  /// ===================================
  /// Getters
  /// ===================================

  function getImageBytes(uint256 tokenId) external view returns (bytes memory) {
    address account = ERC721(erc721KInstance).ownerOf(tokenId);
    return _generateBytesData(tokenId, account);
  }

  function getTraitsBytes(uint256 tokenId) external view returns (bytes memory) {
    address account = ERC721(erc721KInstance).ownerOf(tokenId);
    return _generateBytesData(tokenId, account);
  }

  function getPreview(address account) external view returns (bytes memory imageData) {
    return _generateBytesData(0, account);
  }

  function _generateBytesData(uint256 _tokenId, address account)
    internal
    view
    returns (bytes memory bytesData)
  {
    uint256 balance;
    TwabLib.AccountDetails memory accountDetails;
    RenderMetadata memory renderMetadata;

    renderMetadata.emoji = CardDesign(erc721KDesignInstance).getEmoji(_tokenId);
    renderMetadata.color = CardDesign(erc721KDesignInstance).getColor(_tokenId);

    if (bytes(renderMetadata.emoji).length == 0) {
      renderMetadata.emoji = unicode"💳";
    }

    if (renderMetadata.color.length == 0) {
      renderMetadata.color = DEFAULT_COLOR;
    }

    if (erc20TWABInstance != address(0)) {
      balance = ERC20TWAB(erc20TWABInstance).balanceOf(account);
      accountDetails = ERC20TWAB(erc20TWABInstance).getAccountDetails(account);
      /// Average Balances
      uint64 end = uint64(block.timestamp);
      renderMetadata.avgBalance2Weeks = ERC20TWAB(erc20TWABInstance).getAverageBalanceBetween(
        account,
        uint64(block.timestamp - 2 weeks),
        end
      );
      renderMetadata.avgBalance8Weeks = ERC20TWAB(erc20TWABInstance).getAverageBalanceBetween(
        account,
        uint64(block.timestamp - 8 weeks),
        end
      );
      renderMetadata.avgBalance26Weeks = ERC20TWAB(erc20TWABInstance).getAverageBalanceBetween(
        account,
        uint64(block.timestamp - 26 weeks),
        end
      );
      renderMetadata.avgBalance52Weeks = ERC20TWAB(erc20TWABInstance).getAverageBalanceBetween(
        account,
        uint64(block.timestamp - 52 weeks),
        end
      );
    }

    bytesData = bytes(
      abi.encode(
        account,
        assetUnderlying, // Underlying Asset
        balance, /// Balance
        accountDetails.balance, /// Balance + Delegations
        renderMetadata.avgBalance2Weeks,
        renderMetadata.avgBalance8Weeks,
        renderMetadata.avgBalance26Weeks,
        renderMetadata.avgBalance52Weeks,
        renderMetadata.emoji,
        renderMetadata.color
      )
    );
  }

  function getPreviewWithStyle(
    address account,
    uint8 color,
    uint8 emoji
  ) external view returns (bytes memory bytesData) {
    uint256 balance;
    TwabLib.AccountDetails memory accountDetails;
    RenderMetadata memory renderMetadata;

    renderMetadata.color = CardDesign(erc721KDesignInstance).getColorFromMap(color);
    renderMetadata.emoji = CardDesign(erc721KDesignInstance).getEmojiFromMap(emoji);

    if (bytes(renderMetadata.emoji).length == 0) {
      renderMetadata.emoji = unicode"💳";
    }

    if (renderMetadata.color.length == 0) {
      renderMetadata.color = DEFAULT_COLOR;
    }

    if (erc20TWABInstance != address(0)) {
      balance = ERC20TWAB(erc20TWABInstance).balanceOf(account);
      accountDetails = ERC20TWAB(erc20TWABInstance).getAccountDetails(account);
      /// Average Balances
      uint64 end = uint64(block.timestamp);
      renderMetadata.avgBalance2Weeks = ERC20TWAB(erc20TWABInstance).getAverageBalanceBetween(
        account,
        uint64(block.timestamp - 2 weeks),
        end
      );
      renderMetadata.avgBalance8Weeks = ERC20TWAB(erc20TWABInstance).getAverageBalanceBetween(
        account,
        uint64(block.timestamp - 8 weeks),
        end
      );
      renderMetadata.avgBalance26Weeks = ERC20TWAB(erc20TWABInstance).getAverageBalanceBetween(
        account,
        uint64(block.timestamp - 26 weeks),
        end
      );
      renderMetadata.avgBalance52Weeks = ERC20TWAB(erc20TWABInstance).getAverageBalanceBetween(
        account,
        uint64(block.timestamp - 52 weeks),
        end
      );
    }

    bytesData = bytes(
      abi.encode(
        account,
        assetUnderlying, // Underlying Asset
        balance, /// Balance
        accountDetails.balance, /// Balance + Delegations
        renderMetadata.avgBalance2Weeks,
        renderMetadata.avgBalance8Weeks,
        renderMetadata.avgBalance26Weeks,
        renderMetadata.avgBalance52Weeks,
        renderMetadata.emoji,
        renderMetadata.color
      )
    );
  }

  /// ===================================
  /// Setters
  /// ===================================

  function setERC721KInstance(address _erc721KInstance) external onlyOwner {
    erc721KInstance = _erc721KInstance;
  }

  function setERC721KDesignInstance(address _erc721KDesignInstance) external onlyOwner {
    erc721KDesignInstance = _erc721KDesignInstance;
  }

  function setERC20TWABInstance(address _erc20TWABInstance) external onlyOwner {
    erc20TWABInstance = _erc20TWABInstance;
  }

  /// =====================================================================================
  /// Internal Functions
  /// =====================================================================================

  function _getAverageBalance(
    address _account,
    uint64 _start,
    uint64 _end
  ) internal view returns (uint256) {
    return ERC20TWAB(erc20TWABInstance).getAverageBalanceBetween(_account, _start, _end);
  }
}
