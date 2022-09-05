pragma solidity ^0.8.0;

import "./interfaces/IERC721Enumerable.sol";

import "./ERC721.sol";

contract ERC721Enumerable is ERC721, IERC721Enumerable {

    uint256[] private _allTokens;
    // mapping form token id to position in _allToken
    mapping(uint256 => uint256) private _allTokensIndex;
    // mapping owner to list of all anwer tokern ids
    mapping(address => uint256[]) private _ownerTokens; 
    //mapping token id index of owner tokens list
    mapping(uint256 => uint256) private _ownerTokensIndex;
    
    /// @notice Count NFTs tracked by this contract
    /// @return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address
    function totalSupply() public view override returns (uint256){
        return _allTokens.length;
    }

    /// @notice Enumerate valid NFTs
    /// @dev Throws if `_index` >= `totalSupply()`.
    /// @param _index A counter less than `totalSupply()`
    /// @return The token identifier for the `_index`th NFT,
    ///  (sort order not specified)
    function tokenByIndex(uint256 _index) external view override returns (uint256){
        // index not out of bounds of the total supply

        require(_index < totalSupply(), 'Gloabal index out of bound');
        return _allTokens[_index];
    }

    /// @notice Enumerate NFTs assigned to an owner
    /// @dev Throws if `_index` >= `balanceOf(_owner)` or if
    ///  `_owner` is the zero address, representing invalid NFTs.
    /// @param _owner An address where we are interested in NFTs owned by them
    /// @param _index A counter less than `balanceOf(_owner)`
    /// @return The token identifier for the `_index`th NFT assigned to `_owner`,
    ///   (sort order not specified)
    function tokenOfOwnerByIndex(address _owner, uint256 _index) external view override returns (uint256){
        // index not out of bounds of the total supply
        require(_index < balanceOf(_owner), 'Gloabal owner out of bound');
        return _ownerTokens[_owner][_index];
    }

    function _mint(address to,uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        // q add tokens to onwer
        // 2 alll token our token suppy - to allTOkens

        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private{
            // add address and token id to the _onwer token
            // ownedTokenIndex tokenId set to address of ownedTokens position
            // we want to execute the function with minting
            _ownerTokensIndex[tokenId] = _ownerTokens[to].length;
            _ownerTokens[to].push(tokenId);

    }

    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

}