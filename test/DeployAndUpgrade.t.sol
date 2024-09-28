//SPDX-License-ntifier:MIT 
pragma solidity ^0.8.0;
import {Test,console} from "forge-std/Test.sol";
import {DeployV1} from "script/deployBoxV1.s.sol";
import {UpgradeBox} from "script/upgradeBox.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
contract DeployAndUpgrade is Test {
    DeployV1 public deployer ;
    UpgradeBox public upgrader;
    address public proxy;
    BoxV2  public boxV2;
    function setUp() external {
       deployer = new DeployV1();
       proxy =deployer.run();
       upgrader = new UpgradeBox();
    
    }
    function testVersionOfCurrentDeployed() public  {
        boxV2 = new BoxV2();
        vm.startBroadcast();
        BoxV1(proxy).upgradeToAndCall(address(boxV2),"");
        vm.stopBroadcast();
        assertEq(2,BoxV2(proxy).version());

    }

}