// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {CREATE3Deployer} from "../src/CREATE3Deployer.sol";

error IncorrectAddress();

address constant create3DeployerAddress = 0x004eE012d77C5D0e67D861041D11824f51B590fb;

contract Deploy is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address deterministicDeployer = 0x4e59b44847b379578588920cA78FbF26c0B4956C;

        (bool success, bytes memory data) = deterministicDeployer.call(
            abi.encodePacked(bytes32(0), type(CREATE3Deployer).creationCode)
        );

        if (!success) revert IncorrectAddress();
        if (address(uint160(bytes20(data))) != create3DeployerAddress)
            revert IncorrectAddress();

        vm.stopBroadcast();
    }
}
