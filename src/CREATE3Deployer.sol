// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {CREATE3} from "solady/utils/CREATE3.sol";

contract CREATE3Deployer {
    function deployDeterministic(
        bytes memory initCode,
        bytes32 salt
    ) external returns (address) {
        // hash salt with the deployer address to give each deployer its own namespace
        salt = keccak256(abi.encodePacked(msg.sender, salt));
        return CREATE3.deployDeterministic(initCode, salt);
    }

    function predictDeterministicAddress(
        address deployer,
        bytes32 salt
    ) external view returns (address) {
        // hash salt with the deployer address to give each deployer its own namespace
        salt = keccak256(abi.encodePacked(deployer, salt));
        return CREATE3.predictDeterministicAddress(salt);
    }
}
