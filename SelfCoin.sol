pragma solidity ^0.5.9;

contract SelfCoin {
    
    address public minterAdd;
    mapping( address => uint ) balance;
    
    event Send( address sender, address receiver, uint256 amt );
    
    constructor() public
    {
        minterAdd = msg.sender;
        balance[ minterAdd ] = 100;
    }
     
     function getBalance() public view  returns ( uint256 )  {
         return balance[ msg.sender ];
     }
     
     modifier onlyOwner {
        require(msg.sender == minterAdd, "You Are Not The Owner!!");
        _;
    }
    
    function mint(uint256 val) public onlyOwner {
        balance[ minterAdd ] += val;
    } 
    
    function send( uint256 val, address receiver ) public
    {
        require( balance[ msg.sender ] >= val, "Insufficient Balance" );
     //   assert( balance[ msg.sender ] >= val);
        
        balance[ msg.sender ] -= val;
        balance[ receiver ] += val;
        
        emit Send( msg.sender, receiver, val );
    }
}