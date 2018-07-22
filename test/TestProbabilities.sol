pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EdgeFundBettingFunctions.sol";

contract TestProbabilities
{

    int _ProbabilityKellyCasino = 97223194;
    int _ProbabilityKellyUser = 2776806;
    int _ProbabilityWinCasino = 97368421;
    int _ProbabilityWinUser = 2631578;
    int _ProbabilityFairCasino = 97222223;
    int _ProbabilityFairUser = 2777777;

    EdgeFundBettingFunctions ef;

    constructor() public
    {
        ef = new EdgeFundBettingFunctions();
    }

    function testProbabilityKellyCasino() public
    {
        int expected = _ProbabilityKellyCasino; // 97223194.4
        int actual = ef.getProbabilityKellyCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 97223194.4"
        );
    }

    function testProbabilityKellyUser() public
    {
        int expected = _ProbabilityKellyUser; //2776805.6
        int actual = ef.getProbabilityKellyUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 2776805.6"
        );
    }

    function testProbabilityWinCasino() public
    {
        int expected = _ProbabilityWinCasino; //97368421.1
        int actual = ef.getProbabilityWinCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 97368421.1"
        );
    }

    function testProbabilityWinUser() public
    {
        int expected = _ProbabilityWinUser; //2631578.9
        int actual = ef.getProbabilityWinUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 2631578.9"
        );
    }

    function testProbabilityFairCasino() public
    {
        int expected = _ProbabilityFairCasino; //97222222.2
        int actual = ef.getProbabilityFairCasino();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 97222222.2"
        );
    }

    function testProbabilityFairUser() public
    {
        int expected = _ProbabilityFairUser; //2777777.8
        int actual = ef.getProbabilityFairUser();

        Assert.equal(
            actual,
            expected,
            "Excel calculated number is: 2777777.8"
        );
    }
}
