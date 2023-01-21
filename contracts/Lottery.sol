//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;
import "hardhat/console.sol";

contract Lottery {
    // declaring the state variables
    address[] public players; //dynamic array of type address payable
    address[] public gameWinners;
    address public owner;

modifier onlyOwner() {
require(msg.sender==owner,"ONLY_OWNER");
    _;
}

    // declaring the constructor
    constructor() {
        owner=msg.sender;
        // TODO: initialize the owner to the address that deploys the contract
    }

    // declaring the receive() function that is necessary to receive ETH
    receive() external payable {
        require(msg.value==0.1 ether);
        players.push(msg.sender);
        // TODO: require each player to send exactly 0.1 ETH
        // TODO: append the new player to the players array
    }

    // returning the contract's balance in wei
    function getBalance() public view onlyOwner returns (uint256) {
        // TODO: restrict this function so only the owner is allowed to call it
        // TODO: return the balance of this address
        return address(this).balance;
    }

    // selecting the winner
    function pickWinner() public  onlyOwner{
        // TODO: only the owner can pick a winner 
        // TODO: owner can only pick a winner if there are at least 3 players in the lottery

        // TODO: compute an unsafe random index of the array and assign it to the winner variable 

        // TODO: append the winner to the gameWinners array

        // TODO: reset the lottery for the next round

        // TODO: transfer the entire contract's balance to the winner
        require(players.length>=3,"NOT_ENOUGH_PLAYERS");
        uint256 winnerIndex = random()%players.length;
        address winner = players[winnerIndex];
        gameWinners.push(winner);
        delete players;
        payable(winner).transfer(address(this).balance);

    }

    // helper function that returns a big random integer
    // UNSAFE! Don't trust random numbers generated on-chain, they can be exploited! This method is used here for simplicity
    // See: https://solidity-by-example.org/hacks/randomness
    function random() internal view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.difficulty,
                        block.timestamp,
                        players.length
                    )
                )
            );
    }
}
