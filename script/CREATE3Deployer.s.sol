// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {CREATE3Deployer} from "../src/CREATE3Deployer.sol";

error IncorrectAddress();

bytes32 constant SALT = 0x5361109ca02853ca8e22046b7125306d9ec4ae4cdecc393c567b6be861df3db6;
address constant EXPECTED_ADDRESS = 0x000000000004d4f168daE7DB3C610F408eE22F57;

contract Deploy is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address deterministicDeployer = 0x4e59b44847b379578588920cA78FbF26c0B4956C;

        (bool success, bytes memory data) = deterministicDeployer.call(
            abi.encodePacked(SALT, type(CREATE3Deployer).creationCode)
        );

        if (!success) revert IncorrectAddress();
        if (address(uint160(bytes20(data))) != EXPECTED_ADDRESS)
            revert IncorrectAddress();

        vm.stopBroadcast();
    }
}
