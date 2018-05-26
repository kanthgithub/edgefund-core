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

    function getEdgeKellyCasino() public view returns(uint)
    {
        return (_Multiplier * _UserBetSize) / _BankRoll;
    }

    function getEdgeKellyUser() public view returns(uint)
    {
        /*
        * This sub returns a uint, so it's a positive number, but in reality is
        * negative. Must remember to invert this. Need to consider usability implications
        **/
        uint CasinoLiability = this.getCasinoLiability();
        return (_Multiplier * CasinoLiability) / _BankRoll;
    }

    function getEdgeTotalCasino() public view returns(uint)
    {
        uint ProbabilityWinCasino = this.getProbabilityWinCasino();
        uint CasinoDecimalPayoutOdds = this.getCasinoDecimalPayoutOdds();

        return ((ProbabilityWinCasino * CasinoDecimalPayoutOdds) / _Multiplier) - _Multiplier;
    }

    function getEdgeTotalUser() public view returns(uint)
    {
        return _Multiplier - ((_DecimalPayoutOdds * _Multiplier) / _DecimalWinOdds);
    }

    function getEdgeGameOperatorCasino() public view returns(uint)
    {
        uint EdgeTotalCasino = this.getEdgeTotalCasino();
        uint EdgeKellyCasino = this.getEdgeKellyCasino();

        return EdgeTotalCasino - EdgeKellyCasino;
    }

    function getEdgeGameOperatorUser() public view returns(uint)
    {
        uint EdgeTotalUser = this.getEdgeTotalUser();
        uint EdgeKellyUser = this.getEdgeKellyUser();

        return EdgeTotalUser - EdgeKellyUser;
    }

    function getEVKellyCasino() public view returns(uint)
    {
        uint CasinoLiability = this.getCasinoLiability();
        uint EdgeKellyCasino = this.getEdgeKellyCasino();

        return (CasinoLiability * EdgeKellyCasino) / _Multiplier;
    }
    
    function getEVKellyUser() public view returns(uint)
    {
        uint EdgeKellyUser = this.getEdgeKellyUser();

        return (_UserBetSize * EdgeKellyUser) / _Multiplier;
    }
    
    function getEVTotalCasino() public view returns(uint)
    {
        return _UserBetSize - ((_UserBetSize * _DecimalPayoutOdds) / _DecimalWinOdds);
    }
    
    function getEVTotalUser() public view returns(uint)
    {
        //return (_UserBetSize * EdgeTotalUser) / _Multiplier;
    }

    // function getEVGameOperatorCasino() public view returns(uint)
    // function getEVGameOperatorUser() public view returns(uint)
}