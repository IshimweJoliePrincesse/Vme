//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;
contract HelloWorld {
    string public message;

    constructor () {
        message = "Hello World";
    }
    function setMessage(string memory _message) public {
        message = _message;
    }
}