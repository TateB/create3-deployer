// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CREATE3Deployer} from "../src/CREATE3Deployer.sol";

contract Dummy {}

contract CREATE3DeployerTest is Test {
    CREATE3Deployer public create3Deployer;

    function setUp() public {
        create3Deployer = new CREATE3Deployer();
    }

    function test_DeployDeterministic() public {
        address deployed = create3Deployer.deployDeterministic(
            type(Dummy).creationCode,
            keccak256("salt")
        );
        assertEq(deployed, 0xD95D5C33aaAFEBfF3DdB5f58b3DFD8CAe4717ab6);
    }

    function test_PredictDeterministicAddress() public {
        address deployed = create3Deployer.predictDeterministicAddress(
            address(this),
            keccak256("salt")
        );
        assertEq(deployed, 0xD95D5C33aaAFEBfF3DdB5f58b3DFD8CAe4717ab6);
    }
}
