//SPDX-License-Identifier:MIT 
pragma solidity ^0.8.0;
import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployV1 is Script {

    function run() external returns(address) {
       vm.startBroadcast();
       BoxV1 proxyBoxV1 =  new BoxV1();
       ERC1967Proxy erc1967Proxy = new ERC1967Proxy(address(proxyBoxV1), new bytes(0));
       vm.stopBroadcast();
       return address(erc1967Proxy);
    }

}