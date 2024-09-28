//SPDX-License-Identifier:MIT 

pragma solidity ^0.8.0;
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {ERC1967Proxy} from "lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";
contract UpgradeBox is Script {
    function run()external returns (address){
        address most_recent_deployed_contracts = DevOpsTools.get_most_recent_deployment("ERC1967Proxy",block.chainid);
        vm.startBroadcast();
        BoxV2 boxV2 = new BoxV2();
        vm.stopBroadcast();
        address proxy = upgradeProxy(address(boxV2),most_recent_deployed_contracts);
        return proxy;
    }
    function upgradeProxy(address newBox , address proxyAddress) public returns (address)
    {
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(proxyAddress);
        proxy.upgradeToAndCall(newBox,"");
        vm.stopBroadcast();
        return address(proxy);

    }

}