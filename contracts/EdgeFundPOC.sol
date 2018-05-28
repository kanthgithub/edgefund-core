pragma solidity ^0.4.23;

contract EdgeFundPOC{

    uint _Multiplier = 10**8;

    uint _UserBetSize;
    uint _DecimalPayoutOdds;
    uint _DecimalWinOdds;
    uint _BankRoll;
    uint _FractionalKelly;

    constructor() public
    { 
        //Force this to be a single American roulette bet.
        _UserBetSize = 100 * _Multiplier;
        _DecimalPayoutOdds = 36 * _Multiplier;
        _DecimalWinOdds = 38 * _Multiplier;
        _BankRoll = 10000000 * _Multiplier;
        _FractionalKelly = 1;
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

    function getCasinoLiability() public view returns(uint)
    {
        return (_UserBetSize * (_DecimalPayoutOdds - _Multiplier))/_Multiplier;
    }

    function getFStar() public view returns(uint)
    {
        return (_UserBetSize * (_DecimalPayoutOdds - _Multiplier)) / _BankRoll;
    }

    function getKellyEdge() public view returns(uint)
    {
        return (_UserBetSize * _Multiplier / _BankRoll) * _FractionalKelly;
    }

    function getProbabilityKellyUser() public view returns(uint)
    {
        uint ProbabilityKellyCasino = this.getProbabilityKellyCasino();
        return _Multiplier - ProbabilityKellyCasino;
        // return
        // (
        //     _Multiplier - 
        //     (_Multiplier * 
        //     (_DecimalPayoutOdds - _Multiplier) * 
        //     (_UserBetSize * _FractionalKelly + _BankRoll)) / 
        //     (_BankRoll*_DecimalPayoutOdds)
        // );
    }

    function getProbabilityKellyCasino() public view returns(uint)
    {
        return
        (
            (_Multiplier * 
            (_DecimalPayoutOdds - _Multiplier) * 
            (_UserBetSize * _FractionalKelly + _BankRoll)) / 
            (_BankRoll*_DecimalPayoutOdds)
        );
    }

    function getProbabilityWinUser() public view returns(uint)
    {
        return _Multiplier ** 2 / _DecimalWinOdds;
    }

    function getProbabilityWinCasino() public view returns(uint)
    {
        return (_Multiplier * (_DecimalWinOdds - _Multiplier))/_DecimalWinOdds;
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
        // uint ProbabilityWinCasino = this.getProbabilityWinCasino();
        // uint CasinoDecimalPayoutOdds = this.getCasinoDecimalPayoutOdds();

        // return ((ProbabilityWinCasino * CasinoDecimalPayoutOdds) / _Multiplier) - _Multiplier;

        return ((_Multiplier * _Multiplier * 
        (_DecimalWinOdds - _DecimalPayoutOdds)) / 
        (_DecimalWinOdds * (_DecimalPayoutOdds - _Multiplier)));

        //return (_DecimalPayoutOdds - _DecimalWinOdds) / (_DecimalWinOdds - (_DecimalPayoutOdds * _DecimalWinOdds));
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
        return (_UserBetSize * (_DecimalWinOdds - _DecimalPayoutOdds)) / _DecimalWinOdds;
    }

    function getEVGameOperatorCasino() public view returns(uint)
    {
        uint EVTotalCasino = this.getEVTotalCasino();
        uint EVKellyCasino = this.getEVKellyCasino();

        return EVTotalCasino - EVKellyCasino;
    }
    function getEVGameOperatorUser() public view returns(uint)
    {
        uint EVTotalUser = this.getEVTotalUser();
        uint EVKellyUser = this.getEVKellyUser();

        return EVTotalUser - EVKellyUser;
    }
}