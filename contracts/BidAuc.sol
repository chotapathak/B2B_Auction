// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

contract BiddingContract {
    // User Bid values have user(address) and amount
    struct Bid {
        address payable user;
        uint bidAmount;
    } 
    Bid[] private AllBids;

    address payable public owner;
    uint public startTime;
    uint public endAuction;

    // At the time of deployement intializing empty Bid data
    constructor() public {
        AllBids.push(Bid(address(0), 0));
        owner = msg.sender;
    }

    // modifiers to control the function behaviour
    modifier onlyOwner()
    {
        require(owner == msg.sender,'only owner can use this');
        _;
    }
    
    // this function will handle your funds
    // it automatically triggered at Bidding payment 
    function() payable external {
        startTime = block.timestamp; 
        endAuction = 60 + startTime; // Auction will end in 15 minutes
        uint lastIndex = AllBids.length - 1; // last index of allbids array (index starts from 0)
        require(owner != msg.sender,'Owner cannot bid Own Auction');
        require(msg.value > AllBids[lastIndex].bidAmount, 'Bid should be greater then previous');
        require(startTime<endAuction,'Auction has ended! try next time');

    // if .send fails to send back previous bid amount to it's owner
    // then amount is sent to owner of contract,
    // So your money is safe from been locked in smart contract and sent to me🥹

        if(!AllBids[lastIndex].user.send(AllBids[lastIndex].bidAmount))
        {
            owner.transfer(msg.value);
        }// push the highest bidder's address and bid into the contract
            AllBids.push(Bid(msg.sender, msg.value));
            
            if(block.timestamp > endAuction) // if Auction ended
            {// transfer higest bid to owner
                owner.transfer(msg.value);
            }
    }
    // balance is only visible to owner
    function balance() public view onlyOwner returns (uint)
    {
        return owner.balance;
    }
    // function to know highest bid and highestbidder address
    function TopBid() public view returns (address, uint) 
    {
        uint lastIndex = AllBids.length - 1;
        return (AllBids[lastIndex].user, AllBids[lastIndex].bidAmount);
    }
    // function to get total bid added yet
    function totalBids() public view returns (uint) {
        return AllBids.length-1;
    }
    // function to get details of specific user index
    function getBid(uint index) public view returns (address, uint) // returns address and amount 
    {
        return (AllBids[index].user, AllBids[index].bidAmount);
    }
}