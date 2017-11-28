pragma solidity ^0.4.0;

//Interface outlines functionality for all banks and contracts
interface Regulator{
    function checkValue (uint) returns (bool);
    function loan() returns (bool);
    
}

contract Bank is Regulator {
    uint private value;
    address private owner;
    
    //Access modification - Func based on owner
    modifier ownerFunc{
        require(owner == msg.sender);               //Better than throw - deprecated to 'require'
        _;                                          //executes check BEFORE func in this case
    }
    
    //Constructor
    function Bank(uint amount){
        value = amount;
        owner = msg.sender;                          //only ever be called once, set to creator
    }
    
    function deposit(uint amount) ownerFunc {       //Only owner can deposit - change address to right to test
        value += amount;
    }
    
    function withdraw(uint amount) ownerFunc{       //Only owner can depsosit - change address to right to test
        value -= amount;
    }
    
    function balance() returns (uint){
        return value;
    }
    
    function checkValue(uint amount) returns (bool) {
        return value  >= amount;
    }
    
    //Loan if they have $ in account
    function loan() returns (bool){
        return value > 0;
    }
}

//Inherit from Bank
contract MyFirstContract is Bank{
    string private name;
    uint private age;
    
    function setName(string newName) {
        name = newName;
    }
    
    function getName() returns (string) {
        return name;
    }
    
    function setAge(uint newAge) {
        age = newAge;
    }
    
    function getAge() returns (uint) {
        return age;
    }
}

//Test error handling - gas
contract TestThrows{
    function testAssert() {
        assert(false);
    }
    function testRequire() {
        require(2 == 1);
    }
    function testRevert() {
        revert();                   //Revert gas cost - if you can't complete, give back
    }
    function testThrow() {
        throw;                      //Uses the gas even with error
    }
}