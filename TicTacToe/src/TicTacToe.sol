// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TicTacToe {
    /* 
        This exercise assumes you know how to manipulate nested array.
        1. This contract checks if TicTacToe board is winning or not.
        2. Write your code in `isWinning` function that returns true if a board is winning
           or false if not.
        3. Board contains 1's and 0's elements and it is also a 3x3 nested array.
    */

    function isWinning(uint8[3][3] memory board) public pure returns (bool) {
        // row
        for (uint256 i = 0; i < board.length; i++) {
            bool tmp = true;
            for (uint256 j = 0; j < board[i].length; j++) {
                tmp = tmp && (board[i][j] == 1);
            }
            if (tmp) {
                return true;
            }
        }

        // column
        for (uint256 i = 0; i < board.length; i++) {
            bool tmp = true;
            for (uint256 j = 0; j < board[i].length; j++) {
                tmp = tmp && (board[j][i] == 1);
            }
            if (tmp) {
                return true;
            }
        }

        // diag 00 - 11 - 22
        bool tmp1 = true;
        for (uint256 i = 0; i < board.length; i++) {
            tmp1 = tmp1 && (board[i][i] == 1);
        }
        if (tmp1) {
            return true;
        }

        // diag 02 - 11 - 20
        bool tmp2 = true;
        for (uint256 i = 0; i < board.length; i++) {
            tmp2 = tmp2 && (board[i][board.length - 1 - i] == 1);
        }
        if (tmp2) {
            return true;
        }

        return false;
    }
}
