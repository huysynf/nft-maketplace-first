pragma solidity ^0.8.16;

contract Migration {
    address public owner = msg.sender;
    uint public last_completed_migration;

    modifier restricted() {
        require (msg.sender == owner, "This is not owner");
        _;
    }

    function setCompleted(uint completed) public restricted {
        last_completed_migration = completed;
    }

    function upgrade(address new_address) public restricted {
        Migration upgraded = Migration(new_address);
        upgraded.setCompleted(last_completed_migration);
    }
}