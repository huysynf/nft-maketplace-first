pragma solidity ^0.8.0;


    /*
        1. nft to point to an address
        2. keep track o the token ids
        3 keep track of token owner addresses to token ids
        4 keep track of how many token owner address 
        5 create an event that emits a tanfer log -contracst address
    */


contract ERC721 {

    event Transfer(
        address indexed from, 
        address indexed to, 
        uint256 indexed tokenId);

    // mapping token id to owner
    mapping (uint256 => address) private _tokenOwner;

    // mapping owner to number token

    mapping(address => uint256) _ownerToTokenCount;

    function _exists(uint256 tokenId) internal view returns(bool){
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _mint(address to, uint256 tokenId) internal {
        // required address not zero
        require(to != address(0), 'ERC721 to mint to zero adress');
        // check token exists
        require(!_exists(tokenId), 'ERC721: token already to mint');
        // we adding a new address with token id
        _tokenOwner[tokenId] = to;
        // keep track each addres that mint 
        _ownerToTokenCount[to] += 1;

        emit Transfer(address(0), to, tokenId);
    }
}