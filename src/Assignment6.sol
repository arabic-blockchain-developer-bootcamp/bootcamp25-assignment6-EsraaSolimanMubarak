// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Assignment6 {
    // 1. Declare an event `FundsDeposited` to log deposit transactions
    event FundsDeposited(address indexed sender, uint amount);

    // 2. Declare an event `FundsWithdrawn` to log withdrawal transactions
    event FundsWithdrawn(address indexed receiver, uint amount);

    // 3. A mapping `balances` to track users' balances
    mapping(address => uint) public balances;

    // 4. Modifier to check if the sender has enough balance
    modifier hasEnoughBalance(uint amount) {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        _;
    }

    // 5. Deposit function (must be `external` and `payable`)
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        
        balances[msg.sender] += msg.value;

        emit FundsDeposited(msg.sender, msg.value);
    }

    // 6. Withdraw function (must be `external` and use `hasEnoughBalance` modifier)
    function withdraw(uint amount) external hasEnoughBalance(amount) {
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);

        emit FundsWithdrawn(msg.sender, amount);
    }

    // 7. `getContractBalance` function to return the contract's total balance
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
