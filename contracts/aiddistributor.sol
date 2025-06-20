// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract AidTracker {

    struct Donation {
        address donor;
        string cid;         
        uint256 amount;
        uint256 timestamp;
    }

    struct Distribution {
        string cid;         
        string location;
        uint256 amount;
        uint256 timestamp;
    }

    Donation[] public donations;
    Distribution[] public distributions;

    event DonationReceived(address donor, string cid, uint256 amount, uint256 timestamp);
    event AidDistributed(string cid, string location, uint256 amount, uint256 timestamp);

    function logDonation(string memory _cid, uint256 _amount) public {
        donations.push(Donation({
            donor: msg.sender,
            cid: _cid,
            amount: _amount,
            timestamp: block.timestamp
        }));

        emit DonationReceived(msg.sender, _cid, _amount, block.timestamp);
    }

    function logAid(string memory _cid, string memory _location, uint256 _amount) public {
        distributions.push(Distribution({
            cid: _cid,
            location: _location,
            amount: _amount,
            timestamp: block.timestamp
        }));

        emit AidDistributed(_cid, _location, _amount, block.timestamp);
    }

    function getAllDonations() public view returns (Donation[] memory) {
        return donations;
    }

    function getAllDistributions() public view returns (Distribution[] memory) {
        return distributions;
    }
}
