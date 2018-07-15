pragma solidity ^0.4.24;

contract EdgeFundPOC{

    int _Multiplier = 10 ** 8;

    int _UserBetSize;
    int _DecimalPayoutOdds;
    int _DecimalWinOdds;
    int _BankRoll;
    int _FractionalKelly;

    constructor() public
    {
        //Force this to be a single American roulette bet.
        _UserBetSize = 100 * _Multiplier;
        _DecimalPayoutOdds = 36 * _Multiplier;
        _DecimalWinOdds = 38 * _Multiplier;
        _BankRoll = 10000000 * _Multiplier;
        _FractionalKelly = 1;
    }

    function getMultiplier() public view returns(int)
    {
        return _Multiplier;
    }

    function getBankRoll() public view returns(int)
    {
        return _BankRoll;
    }

    function getCasinoDecimalPayoutOdds() public view returns(int)
    {
        return (_DecimalPayoutOdds * _Multiplier / (_DecimalPayoutOdds - _Multiplier));
    }

    function getCasinoLiability() public view returns(int)
    {
        return (_UserBetSize * (_DecimalPayoutOdds - _Multiplier))/_Multiplier;
    }

    function getFStar() public view returns(int)
    {
        return (_UserBetSize * (_DecimalPayoutOdds - _Multiplier)) / _BankRoll;
    }

    function getKellyEdge() public view returns(int)
    {
        return (_UserBetSize * _Multiplier / _BankRoll) * _FractionalKelly;
    }

    function getProbabilityKellyUser() public view returns(int)
    {
        int ProbabilityKellyCasino = this.getProbabilityKellyCasino();

        return _Multiplier - ProbabilityKellyCasino;
    }

    function getProbabilityKellyCasino() public view returns(int)
    {
        return
        (
            (_Multiplier *
            (_DecimalPayoutOdds - _Multiplier) *
            (_UserBetSize * _FractionalKelly + _BankRoll)) /
            (_BankRoll*_DecimalPayoutOdds)
        );
    }

    function getProbabilityWinUser() public view returns(int)
    {
        return (_Multiplier * _Multiplier) / _DecimalWinOdds;
    }

    function getProbabilityWinCasino() public view returns(int)
    {
        return (_Multiplier * (_DecimalWinOdds - _Multiplier))/_DecimalWinOdds;
    }

    function getProbabilityFairUser() public view returns(int)
    {
        return (_Multiplier * _Multiplier) / _DecimalPayoutOdds;
    }

    function getProbabilityFairCasino() public view returns(int)
    {
        int ProbabilityFairUser = this.getProbabilityFairUser();

        return _Multiplier - ProbabilityFairUser;
    }

    function getEdgeKellyCasino() public view returns(int)
    {
        return (_Multiplier * _UserBetSize) / _BankRoll;
    }

    function getEdgeKellyUser() public view returns(int)
    {
        int CasinoLiability = this.getCasinoLiability();

        return (_Multiplier * CasinoLiability) / _BankRoll;
    }

    function getEdgeTotalCasino() public view returns(int)
    {
        return ((_Multiplier * _Multiplier *
        (_DecimalWinOdds - _DecimalPayoutOdds)) /
        (_DecimalWinOdds * (_DecimalPayoutOdds - _Multiplier)));
    }

    function getEdgeTotalUser() public view returns(int)
    {
        return _Multiplier - ((_DecimalPayoutOdds * _Multiplier) / _DecimalWinOdds);
    }

    function getEdgeGameOperatorCasino() public view returns(int)
    {
        int EdgeTotalCasino = this.getEdgeTotalCasino();
        int EdgeKellyCasino = this.getEdgeKellyCasino();

        return EdgeTotalCasino - EdgeKellyCasino;
    }

    function getEdgeGameOperatorUser() public view returns(int)
    {
        int EdgeTotalUser = this.getEdgeTotalUser();
        int EdgeKellyUser = this.getEdgeKellyUser();

        return EdgeTotalUser - EdgeKellyUser;
    }

    function getEVKellyCasino() public view returns(int)
    {
        int CasinoLiability = this.getCasinoLiability();
        int EdgeKellyCasino = this.getEdgeKellyCasino();

        return (CasinoLiability * EdgeKellyCasino) / _Multiplier;
    }

    function getEVKellyUser() public view returns(int)
    {
        int EdgeKellyUser = this.getEdgeKellyUser();

        return (_UserBetSize * EdgeKellyUser) / _Multiplier;
    }

    function getEVTotalCasino() public view returns(int)
    {
        return _UserBetSize - ((_UserBetSize * _DecimalPayoutOdds) / _DecimalWinOdds);
    }

    function getEVTotalUser() public view returns(int)
    {
        return (_UserBetSize * (_DecimalWinOdds - _DecimalPayoutOdds)) / _DecimalWinOdds;
    }

    function getEVGameOperatorCasino() public view returns(int)
    {
        int EVTotalCasino = this.getEVTotalCasino();
        int EVKellyCasino = this.getEVKellyCasino();

        return EVTotalCasino - EVKellyCasino;
    }

    function getEVGameOperatorUser() public view returns(int)
    {
        int EVTotalUser = this.getEVTotalUser();
        int EVKellyUser = this.getEVKellyUser();

        return EVTotalUser - EVKellyUser;
    }
}
