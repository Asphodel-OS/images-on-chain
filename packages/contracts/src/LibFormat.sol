// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Base64 } from "solady/utils/Base64.sol";
import { LibString } from "solady/utils/LibString.sol";

/// @notice A library for formatting raw bytes into readable images via Base64 encoding.
library LibFormat {
  /// @notice Wraps a raw image in a svg, returning an SVG base64 string.
  /// @dev NFT Marketplaces can only read base64 SVGs, therefore a workaround
  function SVGWrap(string memory data, string memory imgType, bool optimisePixel) internal pure returns (string memory) {
    bytes memory svg = abi.encodePacked(
      '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><image ',
      optimisePixel ? 'height="3000" width="3000" image-rendering="pixelated" ' : "",
      'xlink:href="data:image/',
      imgType,
      ";base64,",
      data,
      '"/></svg>'
    );

    return LibString.concat("data:image/svg+xml;base64,", Base64.encode(svg));
  }

  function SVGWrap(bytes memory data, string memory imgType, bool optimisePixel) internal pure returns (string memory) {
    return SVGWrap(toBase64(data), imgType, optimisePixel);
  }

  function SVGWrap(string memory data, string memory imgType) internal pure returns (string memory) {
    return SVGWrap(data, imgType, false);
  }

  function SVGWrap(bytes memory data, string memory imgType) internal pure returns (string memory) {
    return SVGWrap(toBase64(data), imgType, false);
  }

  /// @notice Encodes a raw bytes array into a Base64 string.
  function toBase64(bytes memory data) internal pure returns (string memory) {
    return Base64.encode(data);
  }
}
