// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    //totalWaves is a state variable initialized to 0 automatically.
    // address addy = msg.sender;

    // struct Wave {
    //     address waver;
    //     uint256 numWaves;
    // }

    // Wave[] public waves;

    mapping (address => uint) public wavers;
    

    constructor() {
        console.log("Every wave increases your odds of success. Wave away!");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function saveWaver() public {
        wavers[msg.sender]++;
        uint256 addyWaves;
        addyWaves =  wavers[msg.sender];
        console.log("%s has waved %d times!", msg.sender, addyWaves);
    }
}