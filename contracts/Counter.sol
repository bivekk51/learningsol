// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Counter{
    uint value;

    constructor(){
        value=10;
    }
    function get() public view returns (uint){
        return value;
    }
    function increment() public{
        value++;
    }
    function decrement() public{
        require(value>0,"value is already zero can't decrease more");
        value--;
    }
}