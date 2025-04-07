// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVoting {
    // Array to store candidate names
    string[] public candidates;

    // Mapping to store the number of votes each candidate received
    mapping(string => uint256) public votes;

    // Mapping to track whether an address has voted
    mapping(address => bool) public hasVoted;

    // Event emitted when a vote is cast
    event Voted(address indexed voter, string candidate);

    // Constructor takes an array of candidate names
    constructor(string[] memory _candidates) {
        require(_candidates.length > 0, "Candidate list cannot be empty.");
        candidates = _candidates;
    }

    // Vote for a candidate
    function vote(string memory candidate) external {
        require(!hasVoted[msg.sender], "You have already voted.");

        // Check if the candidate is valid
        bool isValidCandidate = false;
        for (uint256 i = 0; i < candidates.length; i++) {
            if (keccak256(bytes(candidates[i])) == keccak256(bytes(candidate))) {
                isValidCandidate = true;
                break;
            }
        }
        require(isValidCandidate, "Invalid candidate.");

        // Register the vote
        votes[candidate]++;
        hasVoted[msg.sender] = true;

        emit Voted(msg.sender, candidate);
    }

    // View function to get vote count for a specific candidate
    function getVotes(string memory candidate) external view returns (uint256) {
        return votes[candidate];
    }

    // View function to get all candidates
    function getCandidates() external view returns (string[] memory) {
        return candidates;
    }
}

