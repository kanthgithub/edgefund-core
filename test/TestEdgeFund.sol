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
        uint Multiplier = 10**8;
        uint expected = 10000000 * Multiplier;
        uint actual = ef.getBankrollBalance();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "EdgeFund Bankroll should be configured to have 1000000 initially"
        );
    }

    function testTemporaryCalculation() public
    {
        //Arrange
        EdgeFund ef = EdgeFund(DeployedAddresses.EdgeFund());

        //Act
        uint expected = 97223194;
        uint actual = ef.Temp();
        
        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Test should return 97223194"
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

    function testPlaceBetWithWinOdds() public
    {
        EdgeFund ef = new EdgeFund();
        bool result = ef.PlaceBetWithWinOdds(100, 35, 37);
        Assert.equal(result, true, "failure expected currently");
    }

    function testResolveBets() public
    {
        EdgeFund ef = new EdgeFund();
        bool result = ef.ResolveBets();
        Assert.equal(result, true, "failure expected currently");
    }

}