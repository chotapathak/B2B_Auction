// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// pragma solidity >=0.8.0;

// import { SealedAuction } from './EAuc';
import './Auc.sol';

contract EAucFactory {
    address payable[] public auctions;
    // struct AuctionDetails{
    //     uint bidDecrement;
    //     uint startBlock;
    //     uint endBlock;
    //     string ipfsHash;
    // }
    // mapping (address => AuctionDetails) public auctions;

    event AuctionCreated(address newAuction, address owner, uint numAuctions , address[] allAuctions);

    function AuctFactory() public {

    }

    function createAuction(uint bidDecrement, uint startBlock, uint endBlock, string memory ipfsHash) public {
        Auc newAuction = new Auc(msg.sender, bidDecrement,startBlock,endBlock,ipfsHash);
        // newAuction;
        auctions.push(newAuction);
        // auctions.push(newAuction);
        emit AuctionCreated(newAuction, msg.sender, auctions.length, auctions);

    }

    function allAuctions() public returns (address[] memory) {
        return auctions;
    }
}