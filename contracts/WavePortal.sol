// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
 
    // We will be using this below to help generate a random number
    uint256 private seed;
    

    // Creating an Event so we can late Emit the transaction info for easy finding.
    event NewWave(address indexed from, uint256 timestamp, string message);

    /* Here is a struct here named Wave.
    A struct is basically a custom data type where we can customize what we want to hold inside it.
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


    // This is an address => uint mapping, meaing that I can associate an addy with a number. In this case, I will be storing the address with the last time the user waved at us.
    mapping(address => uint256) public lastWavedAt;


    constructor() payable {
        console.log("We have been constructed!");
        //Set the initial seed
        seed = (block.timestamp + block.difficulty) % 100;
    }

    //The old constructor for reference
    /*
    constructor() {
    console.log("Every wave increases your odds of success. Wave away!");
    */




    /* Here we change the wave function a bit to require a string called "message". This is the message our users send us. 
    */
    function wave(string memory _message) public {
        // we need to make sure that the current timestamp is at least 15mins from the last time this address waved.
       require(
            lastWavedAt[msg.sender] + 30 seconds < block.timestamp, "Please wait 15mins."
        ); 

        // update the current timestamp we have for the user
        lastWavedAt[msg.sender] = block.timestamp;
        
        totalWaves +=1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        // store tthe wave data in the array
        waves.push(Wave(msg.sender, _message, block.timestamp));



        // generate a new seed for the next user that sends a wave
        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %d", seed);

        // Give a 50% chance that the users wins the prize
        if (seed <=50) {
            console.log("%s won!", msg.sender);

            // The same code we had before to send the prize
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance, "Error: Trying to withdrawal more currency than the wallet contains");
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdrawal money from contract.");
            
        }


        // Adding some fanciness by emitting the event where msg.sender is the "from" part of the Event.
        emit NewWave(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");

        console.log("Ether Sent");
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