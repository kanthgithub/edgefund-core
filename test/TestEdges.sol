pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EdgeFundPOC.sol";

contract TestEdges
{
    function testEdgeKellyCasino() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        uint expected = 1000; // 1000.0
        uint actual = ef.getEdgeKellyCasino();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 1000.0"
        );
    }

    function testEdgeKellyUser() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        uint expected = 35000; // 35000
        uint actual = ef.getEdgeKellyUser();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 35000.0. Note, this should be negative. Represented as +ve"
        );
    }

    function testEdgeTotalCasino() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        uint expected = 150376; // 150375.9
        uint actual = ef.getEdgeTotalCasino();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 150375.9"
        );
    }

    function testEdgeTotalUser() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        uint expected = 5263158; // -5263157.9
        uint actual = ef.getEdgeTotalUser();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected -5263157.9"
        );
    }

    function testEdgeGameOperatorCasino() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        uint expected = 149376; // 149375.9
        uint actual = ef.getEdgeGameOperatorCasino();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected 149375.9"
        );
    }

    function testEdgeGameOperatorUser() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        uint expected = 5228158; // -5228157.9
        uint actual = ef.getEdgeGameOperatorUser();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Expected -5228157.9"
        );
    }
}