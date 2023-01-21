//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract KnowledgeTest {
     address public owner;
    string[] public tokens = ["BTC", "ETH"];
    address[] public players;

    modifier onlyOWner() {
        require(msg.sender==owner,"ONLY_OWNER");
        _;
    }
        constructor (){
            owner= msg.sender;
        }
    function changeTokens() public payable {
               tokens[0] = "VET";
    }
    function getBalance() view public returns (uint256 balance) {
        balance=address(this).balance;
    }
    function transferAll(address to) public onlyOWner(){
        payable(to).transfer(address(this).balance);
    }
    function start() external {
        players.push(msg.sender);
    }
    function concatenate(string memory s1,string memory s2) pure external returns (string memory str) {
        str= string(abi.encodePacked(s1,s2));
    }
    receive() external payable{

    } 
}
