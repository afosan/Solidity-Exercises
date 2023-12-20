// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract BasicBank {
    uint256 balance;

    /// @notice deposit ether into the contract
    /// @dev it should work properly when called multiple times
    function addEther() external payable {
        balance += msg.value;
    }

    /// @notice used to withdraw ether from the contract (No restriction on withdrawals)
    function removeEther(uint256 amount) external payable {
        require(amount <= balance, "amount exceeds balance");

        (bool ok, bytes memory result) = payable(msg.sender).call{value: balance}("");
        require(ok, "call fails");
    }
}
