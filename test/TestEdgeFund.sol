pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EdgeFund.sol";

contract TestEdgeFund{
    
    function testInitialBalance() public
    {
        //Arrange
        EdgeFund ef = EdgeFund(DeployedAddresses.EdgeFund());

        //Act
        uint expected = 1000000;
        uint actual = ef.getBankrollBalance();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "EdgeFund Bankroll should be configured to have 1000000 initially"
        );
    }

    function testCasinoDecimalPayoutOdds() public 
    {
        //TODO
        Assert.equal(true, true, "todo");
    }

    function testCasinoPotentialLiability() public 
    {
        //TODO
        Assert.equal(true, true, "todo");
    }

}