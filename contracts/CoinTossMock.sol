pragma solidity ^0.4.24;

import "./CoinToss.sol";

/* This contract inherits the CoinToss Contract, and mocks the random number
 * generation, to simplify the unit testing
 **/
contract CoinTossMock is CoinToss ()
{
    function setBetId(uint betId) public
    {
        counter = betId;
    }

    function getMaxPassedBlocks() public pure returns (uint)
    {
        return 5;
    }

    /* This mocked function 'wins' when the supplied betID is even, and 'loses' when it's odd
     * This allows the function to use the 'pure' modifier, to match the CointToss implementation.
     */
    function getResultForBet(uint betId, bytes32 resutBlockHash) public pure returns (bool)
    {
        resutBlockHash = resutBlockHash; // Suppress warning.

        return (betId % 2) == 0;
    }
}
