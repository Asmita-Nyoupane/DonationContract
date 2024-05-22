// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Donation{

address public admin;

struct Donor{
    string name;
    uint totalAmount;
    uint8 age;
}
 mapping(address => Donor) public donors;

 constructor() payable {
    admin = msg.sender;
 }

 event fundTransfer(address indexed admin , uint amount);
 event  donationReceived( address indexed donor,  uint amount,string name, uint8 age );

modifier onlyAdmin(){
    require(msg.sender == admin,"Only admin can acsess it");
    _;
}

function donate (string memory name, uint8 age ) public payable {
    require( msg.value>0, "Amount must be greater than zero");

Donor storage donor = donors[msg.sender];
donor.totalAmount+=msg.value;
donor.name=name;
donor.age = age;
 emit  donationReceived( msg.sender, msg.value, name,age );
}

function getDetails( address donatedAddress)  public view  returns(string memory name, uint totalAmount, uint8 age){
    Donor storage donor = donors[donatedAddress];
    return( donor.name, donor.totalAmount,donor.age);

}
 function TrasferedFund() public onlyAdmin {
    uint balance = address(this).balance;
require(balance>0,"Balance must be greater than zero");
payable(admin).transfer(balance);
emit fundTransfer(admin, balance);
 }

}