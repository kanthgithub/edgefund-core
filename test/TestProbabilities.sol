pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EdgeFundPOC.sol";

contract TestProbabilities{


    function testProbabilityKellyCasino() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        //uint Multiplier = ef.getMultiplier();
        uint expected = 97223195; // 97223194.4
        uint actual = ef.getProbabilityKellyCasino();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 97223194.4"
        );
    }

    function testProbabilityKellyUser() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        //uint Multiplier = ef.getMultiplier();
        uint expected = 2776805; //2776805.6
        uint actual = ef.getProbabilityKellyUser();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 2776805.6"
        );
    }

    //getProbabilityWinCasino
    function testProbabilityWinCasino() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        uint expected = 97368422; //97368421.1
        uint actual = ef.getProbabilityWinCasino();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 97368421.1"
        );
    }

    //getProbabilityWinUser
    function testProbabilityWinUser() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        //uint Multiplier = ef.getMultiplier();
        uint expected = 2631578; //2631578.9
        uint actual = ef.getProbabilityWinUser();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 2631578.9"
        );
    }

    //getProbabilityWinUser
    function testProbabilityFairUser() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        //uint Multiplier = ef.getMultiplier();
        uint expected = 2777777; //2777777.8
        uint actual = ef.getProbabilityFairUser();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 2777777.8"
        );
    }

    //getProbabilityWinUser
    function testProbabilityFairCasino() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        //uint Multiplier = ef.getMultiplier();
        uint expected = 97222223; //97222222.2
        uint actual = ef.getProbabilityFairCasino();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 97222222.2"
        );
    }
}