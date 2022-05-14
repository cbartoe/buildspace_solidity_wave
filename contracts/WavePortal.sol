// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
 
    // Creating an Event so we can late Emit the transaction info for easy finding.
    event NewWave(address indexed from, uint256 timestamp, string message);

    /* Here is a struct here named Wave.
    A struct is basically a custom data type where we can cuttomize what we want to hold inside it.
    */
    struct Wave {
        address waver; //the addy of the user who is waving
        string message; // the message the user sent.
        uint256 timestamp; // the timestamp when the user waved.
    }




    /* Here we declare a variable 'waves' that lets us store an array of structs.
    this is what lets us hold all the waves anyone ever sends to us.
    */
    Wave[] waves;

    constructor() {
        console.log("I AM SMART CONTRACT. POG.");
    }

    //The old constructor for reference
    /*
    constructor() {
    console.log("Every wave increases your odds of success. Wave away!");
    */




    /* Here we change the wave function a bit to require a string called "message". This is the message our users send us. 
    */
    function wave(sttring memory _message) public {
        totalWaves +=1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        // store tthe wave data in the array
        waves.push(Wave(msg.sender, _message, block.timestamp));

        // Adding some fanciness by emitting the event where msg.sender is the "from" part of the Event.
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    // The old wave function for reference.
    /*
    function wave() public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
    }
    */



    // Function for getAllWaves to return the struct array 'waves' so we can see who has waved and left a message. 
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }



    // functiton to get the total number of waves. 
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }



    // Mapping the number of waves to addresses for my first attempt at tracking waves per sender using the saveWaver function.
    mapping (address => uint) public wavers;
    
    function saveWaver() public {
        wavers[msg.sender]++;
        uint256 addyWaves;
        addyWaves =  wavers[msg.sender];
        console.log("%s has waved %d times!", msg.sender, addyWaves);
    }
}