// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


contract VotingDApp {
    
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    struct Voter {
        bool hasVoted;
        uint votedCandidateId;
    }

  
    address public owner;
    uint public candidateCount;
    bool public votingStarted;
    bool public votingEnded;

    mapping(uint => Candidate) public candidates;
    mapping(address => Voter) public voters;

   
    event CandidateAdded(uint indexed id, string name);
    event Voted(address indexed voter, uint indexed candidateId);
    event VotingStarted();
    event VotingEnded();

 
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier onlyDuringVoting() {
        require(votingStarted && !votingEnded, "Voting is not active");
        _;
    }

    modifier onlyBeforeVoting() {
        require(!votingStarted, "Voting has already started");
        _;
    }

 
    constructor() {
        owner = msg.sender;
    }

 
    function addCandidate(string memory _name) public onlyOwner onlyBeforeVoting {
        candidateCount++;
        candidates[candidateCount] = Candidate(candidateCount, _name, 0);
        emit CandidateAdded(candidateCount, _name);
    }


    function startVoting() public onlyOwner onlyBeforeVoting {
        require(candidateCount >= 2, "Need at least 2 candidates");
        votingStarted = true;
        emit VotingStarted();
    }

  
    function endVoting() public onlyOwner onlyDuringVoting {
        votingEnded = true;
        emit VotingEnded();
    }

    function vote(uint _candidateId) public onlyDuringVoting {
        require(!voters[msg.sender].hasVoted, "You already voted");
        require(_candidateId > 0 && _candidateId <= candidateCount, "Invalid candidate");

        voters[msg.sender] = Voter(true, _candidateId);
        candidates[_candidateId].voteCount++;

        emit Voted(msg.sender, _candidateId);
    }

 
    function getCandidate(uint _id) public view returns (string memory, uint) {
        Candidate memory c = candidates[_id];
        return (c.name, c.voteCount);
    }

   
    function getWinner() public view returns (string memory winnerName, uint winnerVotes) {
        require(votingEnded, "Voting not ended yet");

        uint maxVotes = 0;
        uint winnerId;

        for (uint i = 1; i <= candidateCount; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerId = i;
            }
        }

        Candidate memory winner = candidates[winnerId];
        return (winner.name, winner.voteCount);
    }
}
