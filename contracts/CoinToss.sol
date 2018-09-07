pragma solidity  ^0.4.24;

/* This contract exists only to prove our testing methodology is fit for purpose
 * this will represent a very simple betting function (coin toss) which will be
 * tested with the helper functions that have been created to move the block
 * number, and timestamp forward.
 **/
contract CoinToss
{
    struct Toss
    {
        address user;
        uint block;
        bool isHeads;
        uint amount;
    }

    uint public constant MAXIMUM_PASSED_BLOCKS = 255;
    uint public constant MINIMUM_PASSED_BLOCKS = 5;
    uint public bankroll = 0;
    uint public counter = 0;
    uint public maximumBetSize = 0;

    mapping(uint => Toss) public coinTosses;

    address owner;

    event betPlaced(uint id, address user, bool isHeads, uint amount);
    event CoinTossed(uint id, bool isHeads);

    constructor() public
    {
        owner = msg.sender;
    }

    function placeBet (bool betIsHeads) public payable
    {
        require(msg.value <= maximumBetSize, "Bet is too big");

        coinTosses[counter] = Toss(
            msg.sender,
            block.number + MINIMUM_PASSED_BLOCKS,
            betIsHeads,
            msg.value
        );

        emit betPlaced(counter, msg.sender, betIsHeads, msg.value);

        counter++;
    }

    function getResultForBet(uint betId, bytes32 resutBlockHash) public pure returns (bool)
    {
        bytes32 hashedValue = keccak256(abi.encodePacked(resutBlockHash, betId));
        uint256 result = uint32(hashedValue) % 2;

        return result == 0;
    }

    /* This function exists only to get around a quirk with Solidity inheritance
     * It appears that overriding a constant is ignored when consumed in a sub-class
     * but overriding a function is not ignored. This behaviour should be investigated
     * further to ensure this is anot a security liability for this contract.
     */
    function getMaxPassedBlocks() public pure returns (uint)
    {
        return MAXIMUM_PASSED_BLOCKS;
    }

    function resolveBet(uint betId) public
    {
        Toss storage toss = coinTosses[betId];

        require(msg.sender == toss.user);
        require(block.number >= toss.block);
        require(block.number <= (toss.block + this.getMaxPassedBlocks()));

        bool isHeads = getResultForBet(betId, blockhash(toss.block));

        if (isHeads == toss.isHeads) {
            uint payout = toss.amount * 2; // no house edge...
            msg.sender.transfer(payout);
        }

        emit CoinTossed(betId, isHeads);
        delete coinTosses[betId];
    }

    function fund () payable public
    {
        bankroll += msg.value;
        maximumBetSize = bankroll / 2;
    }

    function () payable public
    {
        bankroll += msg.value;
        maximumBetSize = bankroll / 2;
    }

    function kill () public
    {
        require (msg.sender == owner, "You are not the contract owner");
        selfdestruct(owner);
    }
}
