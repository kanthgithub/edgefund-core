pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EdgeFundPOC.sol";

contract TestEVs
{
    function testEVKellyCasino() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        uint expected = 3500000; // 3500000.0
        uint actual = ef.getEVKellyCasino();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 3500000.0"
        );
    }
    function testEVKellyUser() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        uint expected = 3500000; // 3500000.0
        uint actual = ef.getEVKellyUser();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 3500000.0"
        );
    }
    
    function testEVTotalCasino() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        uint expected = 526315790; // 526315789.5
        uint actual = ef.getEVTotalCasino();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 526315789.5"
        );
    }
    
    // function testEVTotalUser() public
    // {
    //     //Arrange
    //     EdgeFundPOC ef = new EdgeFundPOC();

    //     //Act
    //     uint expected = 526315789; // 526315789.5
    //     uint actual = ef.getEVTotalUser();

    //     //Assert
    //     Assert.equal(
    //         actual, 
    //         expected, 
    //         "Expected 526315789.5"
    //     );
    // }
    // function testEVGameOperatorCasino() public
    // function testEVGameOperatorUser() public
}