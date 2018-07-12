pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EdgeFundPOC.sol";

contract TestEVs
{

    uint _EVKellyCasino = 3500000;
    uint _EVKellyUser = 3500000;
    uint _EVTotalCasino = 526315790;
    uint _EVTotalUser = 526315789; //Should be exactly the same as the Casino number
    uint _EVGameOperatorCasino = 522815790;
    uint _EVGameOperatorUser = 522815790;

    EdgeFundPOC ef;

    constructor()
    {
        ef = new EdgeFundPOC();
    }

    function testEVKellyCasino() public
    {
        uint expected = _EVKellyCasino; // 3500000.0
        uint actual = ef.getEVKellyCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 3500000.0"
        );
    }
    function testEVKellyUser() public
    {
        uint expected = _EVKellyUser; // 3500000.0
        uint actual = ef.getEVKellyUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 3500000.0"
        );
    }
    
    function testEVTotalCasino() public
    {
        uint expected = _EVTotalCasino; // 526315789.5
        uint actual = ef.getEVTotalCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 526315789.5"
        );
    }
    
    function testEVTotalUser() public
    {
        uint expected = _EVTotalUser; // 526315789.5
        uint actual = ef.getEVTotalUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: -526315789.5"
        );
    }

    function testEVGameOperatorCasino() public
    {
        uint expected = _EVGameOperatorCasino; // 522815789.5
        uint actual = ef.getEVGameOperatorCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 522815789.5"
        );
    }

    function testEVGameOperatorUser() public
    {
        uint expected = _EVGameOperatorUser; // -522815789.5
        uint actual = ef.getEVGameOperatorCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: -522815789.5"
        );
    }
}