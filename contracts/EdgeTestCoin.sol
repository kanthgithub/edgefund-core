pragma solidity ^0.4.23;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/MintableToken.sol";

contract EdgeTestCoin is MintableToken{
    string public name = "EDGEFUND COIN";
    string public symbol = "EDG";
    uint8 public decimals = 18;
}