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
            "Excel calculated number is: 1000.0"
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
            "Excel calculated number is: 35000.0. Note, this should be negative. Represented as +ve"
        );
    }

    function testEdgeTotalCasino() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        uint expected = 150375; // 150375.9
        uint actual = ef.getEdgeTotalCasino();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Excel calculated number is: 150375.9"
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
            "Excel calculated number is: -5263157.9"
        );
    }

    function testEdgeGameOperatorCasino() public
    {
        //Arrange
        EdgeFundPOC ef = new EdgeFundPOC();

        //Act
        uint expected = 149375; // 149375.9
        uint actual = ef.getEdgeGameOperatorCasino();

        //Assert
        Assert.equal(
            actual, 
            expected, 
            "Excel calculated number is: 149375.9"
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
            "Excel calculated number is: -5228157.9"
        );
    }
}