// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Base64 } from "solady/utils/Base64.sol";
import { LibString } from "solady/utils/LibString.sol";

/// @notice A library for formatting NFT marketplace readable metadata via Base64 encoded JSONs.
library LibMetadata {
  /// @notice generate metadata in a base64 encoded JSON
  /// @param image image URL
  /// @param name name of the token
  function genMetadata(string memory image, string memory name) internal pure returns (string memory) {
    bytes memory json = abi.encodePacked('{"name":"', name, '","image":"', image, '"}');

    return LibString.concat("data:application/json;base64,", Base64.encode(json));
  }

  /// @notice generate metadata in a base64 encoded JSON
  /// @param image image URL
  /// @param external_url link to external site
  /// @param description description of the token
  /// @param name name of the token
  /// @param attributesName array of token attribute names
  /// @param attributesValue array of token attribute values
  function genMetadata(
    string memory image,
    string memory external_url,
    string memory description,
    string memory name,
    string[] memory attributesName,
    string[] memory attributesValue
  ) internal pure returns (string memory) {
    bytes memory json = abi.encodePacked(
      '{"name":"',
      name,
      '","description":"',
      description,
      '","image":"',
      image,
      '","external_url":"',
      external_url,
      '","attributes":[',
      _genAttributes(attributesName, attributesValue),
      "]}"
    );

    return LibString.concat("data:application/json;base64,", Base64.encode(json));
  }

  /// @notice generate metadata for on-chain images in a base64 encoded JSON
  /// @param image_data base64 encoded svg
  /// @param name name of the token
  function genMetadataRawImage(string memory image_data, string memory name) internal pure returns (string memory) {
    bytes memory json = abi.encodePacked('{"name":"', name, '","animation_url":"', image_data, '"}');

    return LibString.concat("data:application/json;base64,", Base64.encode(json));
  }

  /// @notice generate metadata for on-chain images in a base64 encoded JSON
  /// @param image_data base64 encoded svg
  /// @param external_url link to external site
  /// @param description description of the token
  /// @param name name of the token
  /// @param attributesName array of token attribute names
  /// @param attributesValue array of token attribute values
  function genMetadataRawImage(
    string memory image_data,
    string memory external_url,
    string memory description,
    string memory name,
    string[] memory attributesName,
    string[] memory attributesValue
  ) internal pure returns (string memory) {
    bytes memory json = abi.encodePacked(
      '{"name":"',
      name,
      '","description":"',
      description,
      '","animation_url":"',
      image_data,
      '","external_url":"',
      external_url,
      '","attributes":[',
      _genAttributes(attributesName, attributesValue),
      "]}"
    );

    return LibString.concat("data:application/json;base64,", Base64.encode(json));
  }

  function _genAttributes(string[] memory attributesName, string[] memory attributesValue)
    private
    pure
    returns (string memory)
  {
    require(attributesName.length == attributesValue.length, "attributes length mismatch");

    string memory attributes = "";
    for (uint256 i = 0; i < attributesName.length - 1; i++) {
      attributes = string(
        abi.encodePacked(attributes, '{"trait_type":"', attributesName[i], '","value":"', attributesValue[i], '"},')
      );
    }

    attributes = string(
      abi.encodePacked(
        attributes,
        '{"trait_type":"',
        attributesName[attributesName.length - 1],
        '","value":"',
        attributesValue[attributesName.length - 1],
        '"}'
      )
    );
    return attributes;
  }

  function genMetadata(string memory name, string memory description, string memory image)
    public
    pure
    returns (string memory)
  {
    bytes memory json =
      abi.encodePacked('{"name":"', name, '","description":"', description, '","image":"', image, '"}');

    return LibString.concat("data:application/json;base64,", Base64.encode(json));
  }

  /// @notice Encodes a raw bytes array into a Base64 string.
  function toBase64(bytes memory data) public pure returns (string memory) {
    return Base64.encode(data);
  }
}
