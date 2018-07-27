pragma solidity ^0.4.24;

import "./CoinToss.sol";

/* This contract inherits the CoinToss Contract, and mocks the random number
 * generation, to simplify the unit testing
 **/
contract CoinTossMock is CoinToss ()
{
    function setBetId(uint ID) public
    {
        counter = ID;
    }

    /* This mocked function 'wins' when the supplied betID is even, and 'loses when it's odd
     * This allows the function to use the 'pure' modifier, to match the CointToss
     * Implementation
     */
    function getResultForBet(uint betId, bytes32 resutBlockHash) public pure returns (bool)
    {
        require(resutBlockHash >= 0); // suppress warning.
        require(betId >= 0); // suppress warning.

        return (betId % 2) == 0;
    }
}
