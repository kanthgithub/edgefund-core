pragma solidity ^0.4.23;

contract EdgeFund{

    address _betAddress;
    bool _isHeads;
    uint _betBlock;
    uint Multiplier = 10 ** 8;
    uint FractionalKelly = 1 * Multiplier;
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

    struct UserInteraction{
        uint betSize;
        uint PayoutOdds;
        uint WinOdds;
    }

    mapping(address => Bet[]) playerBets;

    constructor() public
    {
        /*
         * This will be replaced with an ERC20 token. Used to allow some intial
         * testing with the EdgeFund functions
         */
        Bankroll = 10000000 * Multiplier;
    }

    function PlaceBetWithWinOdds (
        uint BetSize,
        uint PayoutOdds,
        uint WinOdds)
        public
        returns(bool)
    {
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

        for (uint i = 0; i < existingBets.length; i++){
            if (!existingBets[i].Resolved)
            {
                /*
                 * Steps to resolve a bet
                 * check that the current block is > the bet-placed block
                 * check that the amount being paid out on this block is < block reward
                 * get the blockhash of the resolving block
                 * get the result of the bet for the given resolution-block
                 */

                require(block.number > existingBets[i].PlacedBlockNumber);

                bytes32 ResolutionblockHash = blockhash(existingBets[i].PlacedBlockNumber + 1);
                bytes32 HashedValue = keccak256(
                    abi.encodePacked(existingBets[i].Player, ResolutionblockHash)
                );
                uint Result = uint8(uint256(HashedValue) % existingBets[i].WinOdds);

                Result == 0 ? true : false;
            }
        }
        return false;
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

    function PlaceBet() public{
        _betAddress = msg.sender;
        _betBlock = block.number;
    }

    function ResolveBet() public pure returns(string) {
        return "ResolveBet called";
    }
}
