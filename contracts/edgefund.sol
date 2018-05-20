pragma solidity ^0.4.23;

/**
* This experimental feature is used temporarily to make it easier to convert the 
* C# POC code to Solidity. It is ESSENTIAL that this is removed and the code
* refactored prior to any kind of deployment. 
*/
pragma experimental ABIEncoderV2;


contract EdgeFund{

    address _betAddress;
    bool _isHeads;
    uint _betBlock;
    uint _dummy;

    uint Multiplier = 10**8;
    uint FractionalKelly = 1 * Multiplier;

    //temporary
    uint Bankroll;

    constructor() public
    { 
        /**
        * This will be replaced with an ERC20 token. Used to allow some intial
        * testing with the EdgeFund functions
        */
        Bankroll = 10000000 * Multiplier;
    }

    /**
    * The default function is called when Ether is sent to this address
    * Need to decide what to do in this scenario. Place a bet? Return funds?
    * Currently favour placing a 'coin toss' bet here. 
    */
    function() public{
    }

    function Temp() public view returns(uint){
        uint BetSize = 100 * Multiplier;
        uint PayoutOdds = 36 * Multiplier;
        //uint WinOdds = 38 * 10^18;
        return Multiplier*(PayoutOdds-Multiplier)*(BetSize*Multiplier+FractionalKelly*Bankroll)/(FractionalKelly*PayoutOdds*Bankroll);
    }

    function PlaceBetWithWinOdds (
        uint BetSize, 
        uint PayoutOdds, 
        uint WinOdds) 
        public
        returns(uint)
    {
        _dummy = 777;
        return _dummy; 
    }

    function PlaceBetWithTotalEdge(
        uint BetSize, 
        uint PayoutOdds, 
        uint TotalEdge) 
        public
        returns(bool)
    {

    }

    struct UserInteraction{
        uint betSize;
        uint PayoutOdds; 
        uint WinOdds;
    }



//Re-work above
////////////////////////////////////////////////////////////////////////////////
//First pass below

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

    function getBankrollBalance() public view returns (uint)
    {
        return Bankroll;
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
        return (LiabilityToBankrollRatio(b) * 
            (CasinoDecimalPayoutOdds(b) - 1)) / b.KellyFraction;
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

    function CalculateEdge(
        uint probability, 
        uint decimalPayoutOdds
        ) 
        private 
        pure 
        returns(uint)
    { 
        return probability * decimalPayoutOdds - 1; 
    }

    function UserEdgeFundKellyEdge(Bet b) public pure returns(uint)
    {
        return CalculateEdge(
            UserProbabilityKelly(b), 
            b.UserDecimalPayoutOdds
        );
    }

    function CasinoEdgeFundKellyEdge(Bet b) public pure returns(uint)
    {
        return CalculateEdge(
            CasinoProbabilityKelly(b), 
            CasinoDecimalPayoutOdds(b)
        );
    }

    // EdgeFund.deployed().then(function(instance){return instance.PlaceBet(true);});
    function PlaceBet(bool isHeads) public{
        _betAddress = msg.sender;
        _isHeads = isHeads;
        _betBlock = block.number;
    }

    // EdgeFund.deployed().then(function(instance){return instance.ResolveBet();});
    function ResolveBet() public view returns(string) {
        bytes32 blockHash = blockhash(_betBlock+1);
        require(blockHash!=0);

        bytes32 shaPlayer = keccak256(_betAddress, blockHash);
        uint CoinTossResult = uint8(uint256(shaPlayer)%2);//heads = 1, tails = 0

        if(CoinTossResult == 1 && _isHeads){
            return "You Win!";            
        } else {
            return "You Lose";
        }
    }

    // For testing with Ganache
    // EdgeFund.deployed().then(function(instance){return instance.ForceNewBlock(123);});
    function ForceNewBlock(uint val) public {
        _dummy = val;
    }
}