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


    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) public view returns (uint256){
        require(_owner != address(0), 'owner query for non-exit');
        return _ownerToTokenCount[_owner];
    }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) external view returns (address){
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'owner query for non-exit');

        return owner;
    }



    function _mint(address to, uint256 tokenId) internal virtual {
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