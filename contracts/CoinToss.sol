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

    uint public constant MAXIMUM_BET_SIZE = 1e18;
    uint public bankroll = 0;
    uint public counter = 0;

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
        require(msg.value <= MAXIMUM_BET_SIZE);

        coinTosses[counter] = Toss(msg.sender, block.number + 5, betIsHeads, msg.value);

        emit betPlaced(counter, msg.sender, betIsHeads, msg.value);

        counter++;
        }

    function getBetById(uint betId) public view returns(address, uint, bool, uint)
    {
        Toss storage toss = coinTosses[betId];

        return (toss.user, toss.block, toss.isHeads, toss.amount);
    }

    function getResultForBet(uint betId, bytes32 resutBlockHash) public pure returns (bool)
    {
        bytes32 hashedValue = keccak256(abi.encodePacked(resutBlockHash, betId));
        uint256 result = uint32(hashedValue) % 2;

        return result == 0;
    }

    function resolveBet(uint betId) public
    {
        Toss storage toss = coinTosses[betId];

        require(msg.sender == toss.user);
        require(block.number >= toss.block);
        require(block.number <= toss.block + 255);

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
    }

    function () payable public
    {
        bankroll += msg.value;
    }

    function kill () public
    {
        require (msg.sender == owner);
        selfdestruct(owner);
    }
}
