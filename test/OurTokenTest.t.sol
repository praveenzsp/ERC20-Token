// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test,console} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";

contract OurTokenTest is Test {
    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    OurToken ot;
    DeployOurToken deployer;

    function setUp() public {
        deployer = new DeployOurToken();
        ot = deployer.run();

        vm.prank(msg.sender); 
        ot.transfer(bob, 10 ether);
    }

    function testBobBalance() public {
        assertEq(ot.balanceOf(bob), 10 ether);
    }

    function testAllowancesWork() public {
        uint256 initialAllowance = 1000;

        vm.prank(bob);
        ot.approve(alice,initialAllowance);

        vm.prank(alice);
        ot.transferFrom(bob, alice, 500);
        // console.log(ot.balanceOf(alice));
        assertEq(ot.balanceOf(alice),500);

    }
}
