pragma solidity ^0.8.16;


import "./ERC721Connector.sol";

contract KryptoBird is ERC721Connector {
  constructor() ERC721Connector('KryptoBird', 'KBIRD')
  {}
}
