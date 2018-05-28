pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EdgeFundPOC.sol";

contract TestProbabilities
{

    uint _ProbabilityKellyCasino = 97223194;
    uint _ProbabilityKellyUser = 2776806;
    uint _ProbabilityWinCasino = 97368421;
    uint _ProbabilityWinUser = 2631578; 
    uint _ProbabilityFairCasino = 97222223;
    uint _ProbabilityFairUser = 2777777;

    EdgeFundPOC ef;

    constructor()
    {
        ef = new EdgeFundPOC();
    }

    function testProbabilityKellyCasino() public
    {
        uint expected = _ProbabilityKellyCasino; // 97223194.4
        uint actual = ef.getProbabilityKellyCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 97223194.4"
        );
    }

    function testProbabilityKellyUser() public
    {
        uint expected = _ProbabilityKellyUser; //2776805.6
        uint actual = ef.getProbabilityKellyUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 2776805.6"
        );
    }

    function testProbabilityWinCasino() public
    {
        uint expected = _ProbabilityWinCasino; //97368421.1
        uint actual = ef.getProbabilityWinCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 97368421.1"
        );
    }

    function testProbabilityWinUser() public
    {
        uint expected = _ProbabilityWinUser; //2631578.9
        uint actual = ef.getProbabilityWinUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 2631578.9"
        );
    }

    function testProbabilityFairCasino() public
    {
        uint expected = _ProbabilityFairCasino; //97222222.2
        uint actual = ef.getProbabilityFairCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 97222222.2"
        );
    }

    function testProbabilityFairUser() public
    {
        uint expected = _ProbabilityFairUser; //2777777.8
        uint actual = ef.getProbabilityFairUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 2777777.8"
        );
    }
}