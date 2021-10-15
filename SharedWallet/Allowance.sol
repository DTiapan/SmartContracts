// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable{
    
    mapping(address => uint) public allowance;
    using SafeMath for uint;
    
    event AllowanceChanged(address indexed _forwho, address indexed _bywho, uint oldamount, uint newamount);

    modifier OwnerorAllowed(uint _amount) {
        require(msg.sender == owner() || allowance[msg.sender] >= _amount, "Only allowed person or owner can perform this operation.");
        _;
    }
    
     function addAllowance(address _who, uint _amount) public onlyOwner() {
        emit AllowanceChanged(_who, owner(), allowance[_who], _amount);
        allowance[_who] = _amount;
    }
    
    function reduceAllowedAmount(address _who, uint _amount) internal {
        emit AllowanceChanged(_who, owner(), allowance[_who],  allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
    }

}
