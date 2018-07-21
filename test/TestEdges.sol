pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EdgeFundBettingFunctions.sol";

contract TestEdges
{
    int _EdgeKellyCasino = 1000;
    int _EdgeKellyUser = 35000;
    int _EdgeTotalCasino = 150375;
    int _EdgeTotalUser = 5263158;
    int _EdgeGameOperatorCasino = 149375;
    int _EdgeGameOperatorUser = 5228158;

    EdgeFundBettingFunctions ef;

    constructor()
    {
        ef = new EdgeFundBettingFunctions();
    }

    function testEdgeKellyCasino() public
    {
        int expected = _EdgeKellyCasino; // 1000.0
        int actual = ef.getEdgeKellyCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 1000.0"
        );
    }

    function testEdgeKellyUser() public
    {
        int expected = _EdgeKellyUser; // 35000
        int actual = ef.getEdgeKellyUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 35000.0. Note, this should be negative. Represented as +ve"
        );
    }

    function testEdgeTotalCasino() public
    {
        int expected = _EdgeTotalCasino; // 150375.9
        int actual = ef.getEdgeTotalCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 150375.9"
        );
    }

    function testEdgeTotalUser() public
    {
        int expected = _EdgeTotalUser; // -5263157.9
        int actual = ef.getEdgeTotalUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: -5263157.9"
        );
    }

    function testEdgeGameOperatorCasino() public
    {
        int expected = _EdgeGameOperatorCasino; // 149375.9
        int actual = ef.getEdgeGameOperatorCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 149375.9"
        );
    }

    function testEdgeGameOperatorUser() public
    {
        int expected = _EdgeGameOperatorUser; // -5228157.9
        int actual = ef.getEdgeGameOperatorUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: -5228157.9"
        );
    }
}