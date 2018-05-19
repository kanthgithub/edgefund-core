pragma solidity ^0.4.23;

contract EdgeFund{

    address _betAddress;
    bool _isHeads;
    uint betBlock;
    uint _dummy;

    constructor() public
    { }

    function PlaceBet(bool isHeads) public{
        _betAddress = msg.sender;
        _isHeads = isHeads;
        betBlock = block.number;
    }

    function ResolveBet() public view returns(string) {
        bytes32 blockHash = block.blockhash(betBlock+1);
        if (blockHash==0) revert();
        bytes32 shaPlayer = keccak256(_betAddress, blockHash);
        uint CoinTossResult = uint8(uint256(shaPlayer)%2);
        //heads = 1, tails = 0

        if(CoinTossResult == 1 && _isHeads){
            return "You Win!";            
        } else {
            return "You Lose";
        }
    }

    function ForceNewBlock(uint val) public {
        _dummy = val;
    }
}