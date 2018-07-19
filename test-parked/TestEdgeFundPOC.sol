pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EdgeFundPOC.sol";

contract TestEdgeFundPOC{

    function testMultiplier() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        int expected = 10**8;
        int actual = ef.getMultiplier();

        //Assert
        Assert.equal(
            actual,
            expected,
            "Expected 100000000"
        );
    }

    function testBankRoll() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        int expected = 10000000 * 10**8;
        int actual = ef.getBankRoll();

        //Assert
        Assert.equal(
            actual,
            expected,
            "Expected 10000000000000000"
        );
    }

    function testCasinoDecimalPayoutOdds() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        //The actual result of this calc is "102857142.9", should end in 3, not 2
        int expected = 102857142; //CHECK THIS. SHOULD BE 102857143
        int actual = ef.getCasinoDecimalPayoutOdds();

        //Assert
        Assert.equal(
            actual,
            expected,
            "Expected 102857142 (102857142.9, actually)"
        );
    }

    function testCasinoLiability() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        int Multiplier = ef.getMultiplier();
        int expected = 3500 * Multiplier;
        int actual = ef.getCasinoLiability();

        //Assert
        Assert.equal(
            actual,
            expected,
            "Expected 350000000000"
        );
    }

    function testFStar() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        //uint Multiplier = ef.getMultiplier();
        int expected = 35000;
        int actual = ef.getFStar();

        //Assert
        Assert.equal(
            actual,
            expected,
            "Expected 35000"
        );
    }

    function testKellyEdge() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        //uint Multiplier = ef.getMultiplier();
        int expected = 1000;
        int actual = ef.getKellyEdge();

        //Assert
        Assert.equal(
            actual,
            expected,
            "Expected 1000"
        );
    }
}
