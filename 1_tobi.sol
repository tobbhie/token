// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SafeMath {

    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }

    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }

    function safeMul(uint a, uint b) public pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }

    function safeDiv(uint a, uint b) public pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}

contract _ercToken is ERC20, Ownable, SafeMath {

    uint256 supply;

    constructor(uint256 initialSupply) ERC20("Tobbhie Inu", "TBI") {

        supply = initialSupply * (10 ** 18);
        _mint(msg.sender, supply);
    }

    function buyToken(address receiver, uint256 amount) public onlyOwner{

        require(amount > 0, "Amount needs to be greater than zero");
        uint rate = 1000;
        uint amountInput = amount * rate;
        _mint(receiver, amountInput);
        _mint(msg.sender, safeAdd(supply, amount));
    }
}