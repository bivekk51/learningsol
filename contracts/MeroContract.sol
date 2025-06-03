// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract MeroNayaContract{
    string contractkovalue;

    constructor() {
        contractkovalue="Khai hau k thiyo";
    }
    function set(string memory nayaContract) public{
        contractkovalue=nayaContract;
    }
    function get() public view returns(string memory) {
        return contractkovalue;
    }

}
