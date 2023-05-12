// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

/// @notice Library for converting between addresses and bytes32 values.
/// @author SolDAO (https://github.com/Sol-DAO/Solbase/blob/main/src/utils/Bytes32AddressLib.sol)
/// @author Modified from Solmate (https://github.com/transmissions11/solmate/blob/main/src/utils/Bytes32AddressLib.sol)
library Bytes32AddressLib {
    function fromLast20Bytes(bytes32 bytesValue) internal pure returns (address) {
        return address(uint160(uint256(bytesValue)));
    }

    function fillLast12Bytes(address addressValue) internal pure returns (bytes32) {
        return bytes32(bytes20(addressValue));
    }
}