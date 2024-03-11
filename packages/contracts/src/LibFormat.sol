// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Base64 } from "solady/utils/Base64.sol";
import { LibString } from "solady/utils/LibString.sol";

/// @notice A library for formatting raw bytes into readable images via Base64 encoding.
library LibFormat {
  /// @notice Wraps a raw image in a html div, returning an HTML base64 string.
  /// @dev NFT Marketplaces cannot read raw base64 images, therefore a workaround
  function HTMLWrap(string memory data, string memory imgType, bool optimisePixel)
    internal
    pure
    returns (string memory)
  {
    bytes memory svg = abi.encodePacked(
      "<div><img ",
      optimisePixel ? 'height="100%" style="image-rendering: pixelated;" ' : "",
      'src="data:image/',
      imgType,
      ";base64,",
      data,
      '"/></div>'
    );

    return LibString.concat("data:text/html;base64,", Base64.encode(svg));
  }

  function HTMLWrap(bytes memory data, string memory imgType, bool optimisePixel) internal pure returns (string memory) {
    return HTMLWrap(toBase64(data), imgType, optimisePixel);
  }

  function HTMLWrap(string memory data, string memory imgType) internal pure returns (string memory) {
    return HTMLWrap(data, imgType, false);
  }

  function HTMLWrap(bytes memory data, string memory imgType) internal pure returns (string memory) {
    return HTMLWrap(toBase64(data), imgType, false);
  }

  /// @notice Encodes a raw bytes array into a Base64 string.
  function toBase64(bytes memory data) internal pure returns (string memory) {
    return Base64.encode(data);
  }
}
