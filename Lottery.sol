// SPDX-License-Identifier: GPL-3.0 ++ identify the license

pragma solidity >=0.8.2 <0.9.0; //version o compiler

contract Lottery {
    address public manager;
    address payable[] public candidates;
    address payable public winner;

    constructor(){
        manager = msg.sender;
    }

    receive() external payable{
        require(msg.value == 0.0000001 ether);
        candidates.push(payable(msg.sender));
    }
    function getbalance() public view returns(uint){
        require(msg.sender == manager);
        return address(this).balance;
    }

    function Random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,candidates.length)));
    }
    function pickwinner() public{
        require(msg.sender == manager);
        require(candidates.length>=2);
        uint K=Random();
        uint index = K%candidates.length;
        winner = candidates[index];
        candidates = new address payable [](0);
    }
}