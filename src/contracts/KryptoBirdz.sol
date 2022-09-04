pragma solidity ^0.8.16;


import "./ERC721Connector.sol";

contract KryptoBird is ERC721Connector {

  // array to store our nft
  string[] public kryptoBirdz;

  mapping(string => bool) _kryptoBirdExists;

  function mint(string memory _krytobird) public {
      require(!_kryptoBirdExists[_krytobird], 'Error: krytobird already exists');


      kryptoBirdz.push(_krytobird);

      uint _id = kryptoBirdz.length - 1;
      _mint(msg.sender, _id);
      _kryptoBirdExists[_krytobird] = true;
  }

  constructor() ERC721Connector('KryptoBird', 'KBIRD')
  {}
}
