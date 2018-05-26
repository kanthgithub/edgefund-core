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
        uint expected = 10**8;
        uint actual = ef.getMultiplier();

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
        uint expected = 10000000 * 10**8;
        uint actual = ef.getBankRoll();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 10000000000000000"
        );
    }

    function testFractionalKelly() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        uint expected = 1;
        uint actual = ef.getFractionalKelly();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 1"
        );
    }

    //getCasinoDecimalPayoutOdds
    function testCasinoDecimalPayoutOdds() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        //The actual result of this calc is "102857142.9", should end in 3, not 2
        uint expected = 102857142; //CHECK THIS. SHOULD BE 102857143
        uint actual = ef.getCasinoDecimalPayoutOdds();

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
        uint Multiplier = ef.getMultiplier();
        uint expected = 3500 * Multiplier;
        uint actual = ef.getCasinoLiability();

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
        uint expected = 35000;
        uint actual = ef.getFStar();

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
        uint expected = 1000;
        uint actual = ef.getKellyEdge();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 1000"
        );
    }

    // function testInitialBalance() public
    // {
    //     //Arrange
    //     EdgeFund ef = EdgeFund(DeployedAddresses.EdgeFund());

    //     //Act
    //     uint Multiplier = 10**8;
    //     uint expected = 10000000 * Multiplier;
    //     uint actual = ef.getBankrollBalance();

    //     //Assert
    //     Assert.equal(
    //         actual, 
    //         expected, 
    //         "EdgeFund Bankroll should be configured to have 1000000 initially"
    //     );
    // }

    // function testTemporaryCalculation() public
    // {
    //     //Arrange
    //     EdgeFund ef = EdgeFund(DeployedAddresses.EdgeFund());

    //     //Act
    //     uint expected = 97223194;
    //     uint actual = ef.Temp();
        
    //     //Assert
    //     Assert.equal(
    //         actual, 
    //         expected, 
    //         "Test should return 97223194"
    //     );
    // }

   
    // function testCasinoDecimalPayoutOdds() public 
    // {
    //     //TODO
    //     Assert.equal(true, true, "todo");
    // }

    // function testCasinoPotentialLiability() public 
    // {
    //     //TODO
    //     Assert.equal(true, true, "todo");
    // }

}