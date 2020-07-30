pragma solidity ^0.5.9;

contract BidderWithTime {
    uint minBid;
    address public curLead;
    uint public hBid;
    uint stTime;
    enum State { Ongoing, Completed }
    State state;
    
    
    constructor( uint _minBid) public
    {
        minBid = _minBid;
        hBid = 0;
        stTime = now;
        state = State.Ongoing;
    }
    
    modifier withinTimeLimit {
        require( state == State.Ongoing );
        _;
    }
    
    function makeBid( uint  curBid )  withinTimeLimit public {
        
        if( now >= stTime + 1 minutes )
        {
            state = State.Completed;
        }
    
        require( curBid > minBid , "Sorry Your Bid is lesser than the min bid. Make a better offer" );
        require( curBid > hBid  , "Sorry Your Bid is lesser than the current highest bid. Make a better offer" );
        
        //  update the highest bid and the new leader in bid
        hBid = curBid;
        curLead = msg.sender;
    }
    
    function getWinner() public view returns (address) {
        
        require( state == State.Completed, "Bidding is still going on" );
        require( hBid != 0, "No suitable bids made" );
        
        return curLead;
    }
    
}