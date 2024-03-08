// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Script, console, VmSafe } from "forge-std/Script.sol";
import { LibString } from "solady/utils/LibString.sol";

/// @notice Cheats to help with scripting
contract ImageCheats is Script {
  /// @notice reads a file raw binary
  function readFile(string memory path) public view returns (bytes memory) {
    return vm.readFileBinary(path);
  }

  /// @notice reads a directory of files
  /// @dev expects a flat directory (no nested directories)
  /// @return string array of file paths in the directory
  function getDirFiles(string memory path) public view returns (string[] memory) {
    VmSafe.DirEntry[] memory files = vm.readDir(path);
    string[] memory filePaths = new string[](files.length);
    for (uint256 i; i < files.length; i++) {
      filePaths[i] = files[i].path;
    }
    return filePaths;
  }

  /// @notice gets file name from an absolute path
  function getFileName(string memory path) public pure returns (string memory) {
    string[] memory strs = LibString.split(path, "/");
    return strs[strs.length - 1];
  }

  /// @notice gets file name from an absolute path
  /// @param path absolute path to file
  /// @param removeExt remove extension from file name if true
  function getFileName(string memory path, bool removeExt) public pure returns (string memory) {
    string[] memory strs = LibString.split(path, "/");
    if (removeExt) {
      strs[strs.length - 1] = LibString.split(strs[strs.length - 1], ".")[0];
    }
    return strs[strs.length - 1];
  }
}
