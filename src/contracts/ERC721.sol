pragma solidity ^0.8.0;

import "./ERC165.sol";
import "./interfaces/IERC721.sol";

    /*
        1. nft to point to an address
        2. keep track o the token ids
        3 keep track of token owner addresses to token ids
        4 keep track of how many token owner address 
        5 create an event that emits a tanfer log -contracst address
    */


contract ERC721 is ERC165, IERC721 {
    // mapping token id to owner
    mapping (uint256 => address) private _tokenOwner;

    // mapping owner to number token

    mapping(address => uint256) _ownerToTokenCount;

    mapping(uint256 => address) _tokenApproval;

    constructor () {
        _registerInterface(bytes4(
        keccak256('balanceOf(bytes4)')
        ^ keccak256('ownerOf(bytes4)')
        ^ keccak256('transferFrom(bytes4)')
        ));
    }

    
    function _exists(uint256 tokenId) internal view returns(bool){
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }


    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) public view override returns (uint256){
        require(_owner != address(0), 'owner query for non-exit');
        return _ownerToTokenCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view override returns (address){
        address owner = _tokenOwner[_tokenId];
        require( owner != address(0), 'owner query for non-exit');
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

    function approve(address _to, uint256 _tokenId) public {
        address owner = ownerOf(_tokenId);
        require(_to != owner, 'Error: Appro to current owner');
        require(msg.sender != owner, 'Error: Current caller to current owner');
        _tokenApproval[_tokenId] = _to;

        emit Approval(owner, _to, _tokenId);
    }


    function _transferFrom(address _from,address _to,uint256 _tokenId) internal {
        require(_to != address(0), 'Error - ERC 721 tranfer zero address');
        require(ownerOf(_tokenId) == _from, 'Trying tranfer token address does not exists');

        _ownerToTokenCount[_from] -= 1;
        _ownerToTokenCount[_to] += 1;
        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from,address _to,uint256 _tokenId) public payable override {
        require(isApprovedOrOwner(msg.sender, _tokenId));
        _transferFrom(_from, _to, _tokenId);

    }

    function isApprovedOrOwner(address spender, uint256 tokenId) internal view returns(bool) {
        require(_exists(tokenId), 'Token not exits');
        address owner = ownerOf(tokenId);
        return (spender == owner);
    }
}