// SPDX-License-Identifier: GPL-3.0
pragma solidity  >=0.7.0 <0.9.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";

contract sharedWallet {
    //1. Deposit functionality
    using SafeMath for uint;
    uint public totalBal;
    address private owner;
    mapping(string => uint) private allowanceMapping;
    
    constructor() {
        owner = msg.sender;
        allowanceMapping["Student"] = 2;
        allowanceMapping["Teacher"] = 5;
        allowanceMapping["HeadeMaster"] = 8;
    }
    //
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this operation.");
        _;
    }
    
    //function to desposit the money, any person can deposit the money to wallet.
    function despositMoney() public payable {
        require(msg.value > 0, "Deposit Value to  should be greater than 0");
        totalBal = totalBal.add(msg.value);
    }
    
    //function to withdrawMoney from wallet
    
    function withdrawMoney(address payable _to, string memory partyType, uint _amountTowithdraw) public {
        require(totalBal >= _amountTowithdraw, "Insufficient Balance");
        totalBal = totalBal.sub( _amountTowithdraw*allowanceMapping[partyType]);
        _to.transfer(_amountTowithdraw);
    }
    
    function withdrawMoneyOwner(address payable _to, uint _amountTowithdraw) public onlyOwner(){
        require(totalBal >= _amountTowithdraw, "Insufficient Balance");
        totalBal = totalBal.sub( _amountTowithdraw);
        _to.transfer(_amountTowithdraw);
    }
    
    function changeAllowancLimit(string memory partyType, uint updatedAllowance) public onlyOwner(){
        allowanceMapping[partyType] = updatedAllowance;
    }
    
    
}