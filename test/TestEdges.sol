pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EdgeFundPOC.sol";

contract TestEdges
{
    uint _EdgeKellyCasino = 1000;
    uint _EdgeKellyUser = 35000;
    uint _EdgeTotalCasino = 150375;
    uint _EdgeTotalUser = 5263158;
    uint _EdgeGameOperatorCasino = 149375;
    uint _EdgeGameOperatorUser = 5228158;

    EdgeFundPOC ef;

    constructor()
    {
        ef = new EdgeFundPOC();
    }

    function testEdgeKellyCasino() public
    {
        uint expected = _EdgeKellyCasino; // 1000.0
        uint actual = ef.getEdgeKellyCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 1000.0"
        );
    }

    function testEdgeKellyUser() public
    {
        uint expected = _EdgeKellyUser; // 35000
        uint actual = ef.getEdgeKellyUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 35000.0. Note, this should be negative. Represented as +ve"
        );
    }

    function testEdgeTotalCasino() public
    {
        uint expected = _EdgeTotalCasino; // 150375.9
        uint actual = ef.getEdgeTotalCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 150375.9"
        );
    }

    function testEdgeTotalUser() public
    {
        uint expected = _EdgeTotalUser; // -5263157.9
        uint actual = ef.getEdgeTotalUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: -5263157.9"
        );
    }

    function testEdgeGameOperatorCasino() public
    {
        uint expected = _EdgeGameOperatorCasino; // 149375.9
        uint actual = ef.getEdgeGameOperatorCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 149375.9"
        );
    }

    function testEdgeGameOperatorUser() public
    {
        uint expected = _EdgeGameOperatorUser; // -5228157.9
        uint actual = ef.getEdgeGameOperatorUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: -5228157.9"
        );
    }
}