// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */

    address currentHighestDepositAddress;
    uint256 currentHighestDepositAmount;
    uint256 endTime;

    function bet() public payable {
        require(endTime == 0 || block.timestamp <= endTime, "betting ended");
        if (msg.value > currentHighestDepositAmount) {
            currentHighestDepositAddress = msg.sender;
            currentHighestDepositAmount = msg.value;
            endTime = block.timestamp + 1 hours;
        }
    }

    function claimPrize() public {
        require(msg.sender == currentHighestDepositAddress, "not winner");
        require(block.timestamp > endTime, "betting not ended");

        (bool ok, ) = payable(currentHighestDepositAddress).call{value: address(this).balance}("");
        require(ok, "claim failed");
    }
}
