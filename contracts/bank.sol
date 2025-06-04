// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract BankContract{

    mapping(address=>uint)public balances;
    address public owner;

    //Events haru log gardim 

    event Deposit(address indexed sender,uint amount);
    event Withdraw(address indexed receiver,uint amount);

    constructor(){
        owner=msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender==owner,"You aren't the owner");
        _;
    }

    function withdrawAll() public onlyOwner{
        //yo chai owner ley matra access garna sakxa
        payable(msg.sender).transfer(address(this).balance);
    }

    function getIndividualBalance() public view returns(uint){
        return balances[msg.sender];
    }
    function deposit() public payable{
        balances[msg.sender]+=msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    function withdraw(uint amount) public{
        //balance huna paryo sufficient withdraw garnaa
        require(balances[msg.sender]>=amount,"Insufficient balance, can't withdraw");
        //balance ghatauney
        balances[msg.sender]-=amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }
    function getTotalBalance() public view returns(uint){
        return address(this).balance;
    }
}