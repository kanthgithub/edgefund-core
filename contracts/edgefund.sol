pragma solidity ^0.4.23;

contract EdgeFund{

    address _betAddress;
    bool _isHeads;
    uint _betBlock;
    uint _dummy;

    uint Multiplier = 10**8;
    uint FractionalKelly = 1 * Multiplier;

    //temporary
    uint Bankroll;

    struct Bet{
        uint BetSize;
        uint PayoutOdds;
        uint WinOdds;

        uint PlacedBlockNumber;
        uint PlayerBetIndex;
        address Player;

        bool Resolved;
    }

    mapping(address => Bet[]) playerBets;

    function PlaceBetWithWinOdds (
        uint BetSize,
        uint PayoutOdds,
        uint WinOdds)
        public
        returns(bool)
    {
       // Bet b;
        //b.Betsize = BetSize;
        Bet[] storage existingBets = playerBets[msg.sender];
        uint numBets = existingBets.length;
        existingBets.push(
            Bet(
                BetSize,
                PayoutOdds,
                WinOdds,
                block.number,
                numBets++,
                msg.sender,
                false
            ));

        return false;
    }

    function ResolveBets() public view returns(bool)
    {
        Bet[] storage existingBets = playerBets[msg.sender];
        for(uint i = 0; i < existingBets.length; i++){
            if(!existingBets[i].Resolved)
            {
                /*
                * Steps to resolve a bet
                * check that the current block is > the bet-placed block
                * check that the amount being paid out on this block is < block reward
                * get the blockhash of the resolving block
                * get the result of the bet for the given resolution-block
                */

                require(block.number > existingBets[i].PlacedBlockNumber);
                bytes32 ResolutionblockHash = blockhash(existingBets[i].PlacedBlockNumber+1);
                bytes32 HashedValue = keccak256(abi.encodePacked(existingBets[i].Player, ResolutionblockHash));
                uint Result = uint8(uint256(HashedValue)%existingBets[i].WinOdds);
                Result == 0 ? true : false;
            }
        }
        return false;
    }

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
        return Multiplier *
            (PayoutOdds - Multiplier) *
            (BetSize * Multiplier + FractionalKelly * Bankroll) /
            (FractionalKelly * PayoutOdds * Bankroll);
    }

    struct UserInteraction{
        uint betSize;
        uint PayoutOdds;
        uint WinOdds;
    }

    function getBankrollBalance() public view returns (uint)
    {
        return Bankroll;
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

        bytes32 HashedValue = keccak256(abi.encodePacked(_betAddress, blockHash));
        uint CoinTossResult = uint8(uint256(HashedValue)%2);//heads = 1, tails = 0

        if (CoinTossResult == 1 && _isHeads){
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
