// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";
import "./Allowance.sol";

contract SharedWallet is Allowance{

    uint public bal;
    event MoneyTransferred(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    using SafeMath for uint;
    constructor() public payable{
        bal = msg.value;
        emit MoneyReceived(owner(), bal);
    }
    
   
    
    function withdrawMoney(address payable _to, uint _amount) public OwnerorAllowed(_amount) {
        require(_amount <= address(this).balance, "Amount should less than or equal to total bal");
        bal = bal.sub(_amount);
        if (msg.sender != owner()) {
            reduceAllowedAmount( _to,  _amount);
        }
        emit MoneyTransferred(_to, _amount);
        _to.transfer(_amount);
    }
    
    function renounceOwnership() public override(Ownable) {
        revert("cant renounce ownership");
    }
    
   
}
