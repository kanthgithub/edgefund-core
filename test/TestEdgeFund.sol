pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EdgeFund.sol";

contract TestEdgeFund{

    EdgeFund ef;

    constructor() public
    {
        ef = new EdgeFund();
    }

    function testTemp() view public{
        ef.ResolveBets();
        assert(true);
    }
}
