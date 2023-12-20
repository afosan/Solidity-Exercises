// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */

    mapping(address => uint256) balances;
    mapping(address => uint256) lastDepositAts;

    function balanceOf(address user) public view returns (uint256) {
        // return the user's balance in the contract
        return balances[user];
    }

    function depositEther() external payable {
        /// add code here
        balances[msg.sender] += msg.value;
        lastDepositAts[msg.sender] = block.timestamp;
    }

    function withdrawEther(uint256 amount) external {
        /// add code here
        require(lastDepositAts[msg.sender] + 1 weeks <= block.timestamp, "user balance is still locked");
        require(amount <= balances[msg.sender], "amount exceeds user balance");

        balances[msg.sender] -= amount;
        (bool ok, ) = payable(msg.sender).call{value: amount}("");
        require(ok, "withdraw failed");
    }
}
