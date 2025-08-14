// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {CREATE3} from "solady/utils/CREATE3.sol";

/// @title CREATE3Deployer
/// @notice Minimal wrapper around Solady's CREATE3 for deterministic contract deployments.
/// @dev The effective salt is keccak256(abi.encodePacked(deployer, salt)) to namespace callers.
contract CREATE3Deployer {
    /// @notice Deploy a contract deterministically using CREATE3.
    /// @dev Effective salt is keccak256(abi.encodePacked(msg.sender, salt)). Forwards msg.value to the constructor.
    /// @param initCode Creation bytecode.
    /// @param salt User-provided salt prior to namespacing with the caller address.
    /// @return deployed Address of the deployed contract.
    function deployDeterministic(
        bytes memory initCode,
        bytes32 salt
    ) external payable returns (address) {
        // hash salt with the deployer address to give each deployer its own namespace
        salt = keccak256(abi.encodePacked(msg.sender, salt));
        return CREATE3.deployDeterministic(msg.value, initCode, salt);
    }

    /// @notice Predict the deterministic deployment address for a given deployer and salt.
    /// @dev Mirrors the salt namespacing in deployDeterministic: keccak256(abi.encodePacked(deployer, salt)).
    /// @param deployer Address that will call deployDeterministic.
    /// @param salt User-provided salt prior to namespacing.
    /// @return predicted The predicted deployment address.
    function predictDeterministicAddress(
        address deployer,
        bytes32 salt
    ) external view returns (address) {
        // hash salt with the deployer address to give each deployer its own namespace
        salt = keccak256(abi.encodePacked(deployer, salt));
        return CREATE3.predictDeterministicAddress(salt);
    }
}
