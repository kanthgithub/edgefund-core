pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EdgeFundPOC.sol";

contract TestEVs
{

    int _EVKellyCasino = 3500000;
    int _EVKellyUser = 3500000;
    int _EVTotalCasino = 526315790;
    int _EVTotalUser = 526315789; //Should be exactly the same as the Casino number
    int _EVGameOperatorCasino = 522815790;
    int _EVGameOperatorUser = 522815790;

    EdgeFundPOC ef;

    constructor()
    {
        ef = new EdgeFundPOC();
    }

    function testEVKellyCasino() public
    {
        int expected = _EVKellyCasino; // 3500000.0
        int actual = ef.getEVKellyCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 3500000.0"
        );
    }
    function testEVKellyUser() public
    {
        int expected = _EVKellyUser; // 3500000.0
        int actual = ef.getEVKellyUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 3500000.0"
        );
    }
    
    function testEVTotalCasino() public
    {
        int expected = _EVTotalCasino; // 526315789.5
        int actual = ef.getEVTotalCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 526315789.5"
        );
    }
    
    function testEVTotalUser() public
    {
        int expected = _EVTotalUser; // 526315789.5
        int actual = ef.getEVTotalUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: -526315789.5"
        );
    }

    function testEVGameOperatorCasino() public
    {
        int expected = _EVGameOperatorCasino; // 522815789.5
        int actual = ef.getEVGameOperatorCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 522815789.5"
        );
    }

    function testEVGameOperatorUser() public
    {
        int expected = _EVGameOperatorUser; // -522815789.5
        int actual = ef.getEVGameOperatorCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: -522815789.5"
        );
    }
}