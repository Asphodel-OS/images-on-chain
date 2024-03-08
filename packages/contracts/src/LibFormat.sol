// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Base64 } from "solady/utils/Base64.sol";
import { LibString } from "solady/utils/LibString.sol";

/// @notice A library for formatting raw bytes into readable images via Base64 encoding.
library LibFormat {
  /// @notice Encodes a raw bytes array into a Base64 string.
  function toBase64(bytes memory data) public pure returns (string memory) {
    return Base64.encode(data);
  }

  /// @notice Wraps a raw image in a svg, returning an SVG base64 string.
  /// @dev NFT Marketplaces can only read base64 SVGs, therefore a workaround
  function SVGWrap(string memory data, string memory imgType) public pure returns (string memory) {
    bytes memory svg = abi.encodePacked(
      '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><image xlink:href="data:image/',
      imgType,
      ";base64,",
      data,
      '"/></svg>'
    );

    return LibString.concat("data:image/svg+xml;base64,", Base64.encode(svg));
  }
}
