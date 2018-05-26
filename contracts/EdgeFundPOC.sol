pragma solidity ^0.4.23;

contract EdgeFundPOC{

    uint _Multiplier = 10**8;

    uint _UserBetSize;
    uint _DecimalPayoutOdds;
    uint _DecimalWinOdds;
    uint _BankRoll;

    constructor() public
    { 
        //Force this to be a single American roulette bet.
        _UserBetSize = 100 * _Multiplier;
        _DecimalPayoutOdds = 36 * _Multiplier;
        _DecimalWinOdds = 38 * _Multiplier;
        _BankRoll = 10000000 * _Multiplier;
    }

    function getMultiplier() public view returns(uint)
    {
        return _Multiplier;
    }

    function getBankRoll() public view returns(uint)
    {
        return _BankRoll;
    }

    function getCasinoDecimalPayoutOdds() public view returns(uint)
    {
        return (_DecimalPayoutOdds * _Multiplier / (_DecimalPayoutOdds - _Multiplier));
    }

    function getFractionalKelly() public pure returns(uint)
    {
        return 1;
    }

    function getCasinoLiability() public view returns(uint)
    {
        return (_UserBetSize * (_DecimalPayoutOdds - _Multiplier))/_Multiplier;
    }

    function getFStar() public view returns(uint)
    {
        uint CasinoLiability = this.getCasinoLiability();
        return (CasinoLiability * _Multiplier) / _BankRoll;
    }

    function getKellyEdge() public view returns(uint)
    {
        uint FractionalKelly = this.getFractionalKelly();
        return (_UserBetSize * _Multiplier / _BankRoll) * FractionalKelly;
    }

    // P Kelly / Win / Fair (Casino / User)

    function getProbabilityKellyUser() public view returns(uint)
    {
        uint ProbabilityKellyCasino = this.getProbabilityKellyCasino();
        return _Multiplier - ProbabilityKellyCasino;
    }

    function getProbabilityKellyCasino() public view returns(uint)
    {
        uint KellyEdge = getKellyEdge();
        uint CasinoDecimalPayoutOdds = getCasinoDecimalPayoutOdds();

        return ((KellyEdge + _Multiplier) * _Multiplier) / CasinoDecimalPayoutOdds;
    }

    function getProbabilityWinUser() public view returns(uint)
    {
        return _Multiplier ** 2 / _DecimalWinOdds;
    }

    function getProbabilityWinCasino() public view returns(uint)
    {
        uint ProbabilityWinUser = this.getProbabilityWinUser();
        return _Multiplier - ProbabilityWinUser;
    }

    function getProbabilityFairUser() public view returns(uint)
    {
        return _Multiplier ** 2 / _DecimalPayoutOdds;
    }

    function getProbabilityFairCasino() public view returns(uint)
    {
        uint ProbabilityFairUser = this.getProbabilityFairUser();
        return _Multiplier - ProbabilityFairUser;
    }
}