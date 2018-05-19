pragma solidity ^0.4.23;
pragma experimental ABIEncoderV2;


contract EdgeFund{

    address _betAddress;
    bool _isHeads;
    uint betBlock;
    uint _dummy;

    constructor() public
    { }

    struct Bet{
        address Player;
        uint UserRequestedBetSize;
        uint UserDecimalPayoutOdds;
        uint UserDecimalWinOdds;
        uint BankRollPriorToBet;
        uint KellyFraction;
        uint liabilityLimit;
        bool LiabilityLimit;

        bool Resolved;
    }


    function CasinoDecimalPayoutOdds(Bet b) public pure returns(uint){
        return b.UserDecimalPayoutOdds / (b.UserDecimalPayoutOdds - 1);
    }

    function CasinoPotentialLiability(Bet b) public pure returns(uint){
        return b.UserRequestedBetSize * (b.UserDecimalPayoutOdds - 1);
    }

    function LiabilityToBankrollRatio(Bet b) public pure returns(uint){
        return CasinoPotentialLiability(b) / b.BankRollPriorToBet;
    }

    function KellyEdge(Bet b) public pure returns(uint){
        return (LiabilityToBankrollRatio(b) * (CasinoDecimalPayoutOdds(b) - 1)) / b.KellyFraction;
    }

    function UserProbabilityKelly(Bet b) public pure returns(uint){
        return 1 - CasinoProbabilityKelly(b);
    }
    
    function CasinoProbabilityKelly(Bet b) public pure returns(uint){
        return (KellyEdge(b) + 1) / CasinoDecimalPayoutOdds(b); 
    }

    function UserProbabilityWin(Bet b) public pure returns(uint){
        return  1 / b.UserDecimalWinOdds;
    }

    function CasinoProbabilityWin(Bet b) public pure returns(uint){
        return 1 - UserProbabilityWin(b); 
    }

    function UserProbabilityFair(Bet b) public pure returns(uint){
        return 1 / b.UserDecimalPayoutOdds;
    }

    function CasinoProbabilityFair(Bet b) public pure returns(uint){
        return 1 / CasinoDecimalPayoutOdds(b);
    }

    function CalculateEdge(uint probability, uint decimalPayoutOdds) private pure returns(uint)
    { 
        return probability * decimalPayoutOdds - 1; 
    }

    function UserEdgeFundKellyEdge(Bet b) public pure returns(uint)
    {
        return CalculateEdge(UserProbabilityKelly(b), b.UserDecimalPayoutOdds);
    }

    function CasinoEdgeFundKellyEdge(Bet b) public pure returns(uint)
    {
        return CalculateEdge(CasinoProbabilityKelly(b), CasinoDecimalPayoutOdds(b));
    }


    function PlaceBet(bool isHeads) public{
        _betAddress = msg.sender;
        _isHeads = isHeads;
        betBlock = block.number;
    }

    function ResolveBet() public view returns(string) {
        bytes32 blockHash = blockhash(betBlock+1);
        require(blockHash!=0);
        //if (blockHash==0) revert();
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