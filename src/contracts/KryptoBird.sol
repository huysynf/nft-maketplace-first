pragma solidity ^0.8.16;


import "./ERC721Connector.sol";

contract KryptoBird is ERC721Connector {

  // array to store our nft
  string[] public kryptoBirdz;

  mapping(string => bool) _kryptoBirdExists;

  function mint(string memory _kryptoBird) public {
      require(!_kryptoBirdExists[_kryptoBird], 'Error: krytobird already exists');
      kryptoBirdz.push(_kryptoBird);
      uint _id = kryptoBirdz.length - 1;
      _mint(msg.sender, _id);
      _kryptoBirdExists[_kryptoBird] = true;
  }

  constructor() ERC721Connector('KryptoBird', 'KBIRD'){}
}
