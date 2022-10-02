// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

error You_can_only_mint_1_NFT();
error You_can_only_mint_2_NFT();
error You_are_not_genuine();
error Not_Enough_Ethers_Sent();
error Mint_Not_Yet_Started();
error Not_Enough_Tokens_Left();
error Wait_Till_Skull_Mint_Starts();
error WhiteListers_Still_Have_Time_To_Mint();

contract skullSyndicate is ERC721A, Ownable {
    uint256 internal MAX_MINTS = 2;
    uint256 internal Public_Mints;
    uint256 internal Skull_Mints;
    uint256 internal WL_Mints;
    uint256 internal MAX_SUPPLY = 2500;
    uint256 internal mint_Price = 0.015 ether;
    uint256 internal skull_List_Mint_Price = 0.009 ether;
    uint32 internal mint_Time = 1664709300;
    uint32 internal Skull_List_Time = 1664710200;
    uint32 internal whiteList_Time = 1664711100;
    // bool internal paused = false;
    address internal DeveloperAddress =
        0xB96DfC3e4cBE9Da6F072d57c13b5EfB44c8b192C;
    address internal OwnerAddress = 0x2E3D02c126E75Ad3B4c95DB3A78E83044d39bf31;
    uint96 internal royaltyFeesInBips;
    address internal royaltyReceiver;
    // uint256 number;
    uint256 internal amount;
    string internal contractURI;
    bytes32 internal whiteList_root;
    bytes32 internal skull_root;
    bool internal checkWL;
    bool internal checkSkull;

    string internal baseURI =
        "https://gateway.pinata.cloud/ipfs/Qmc1Azz4h3zcg2fZrTbTEmq7jNfyNoDmE8U8SbQWTn1cso/";

    // mapping(address => bool) public whitelisted;

    constructor(
        uint96 _royaltyFeesInBips,
        string memory _contractURI,
        bytes32 _whiteList_root,
        bytes32 _skull_root
    ) ERC721A("Indie Skull Syndicate", "$kull") {
        royaltyFeesInBips = _royaltyFeesInBips;
        contractURI = _contractURI;
        whiteList_root = _whiteList_root;
        skull_root = _skull_root;
        royaltyReceiver = msg.sender;
        _safeMint(msg.sender, 31);
    }

    function mint(
        uint256 quantity,
        bytes32[] memory proof,
        bytes32 leaf
    ) external payable {
        // _safeMint's second argument takes in a quantity, not a tokenId.

        // if (totalSupply() + quantity <= MAX_SUPPLY) {
        //     revert Not_Enough_Tokens_Left();
        // }
        require(
            totalSupply() + quantity <= MAX_SUPPLY,
            "Not Enough Tokens Left"
        );

        // if (keccak256(abi.encodePacked(msg.sender)) == leaf) {
        //     revert You_are_not_genuine();
        // }
        // require(
        //     keccak256(abi.encodePacked(msg.sender)) == leaf,
        //     "You are not genuine"
        // );

        checkWL = whiteList_MerkleVerify(proof, leaf);
        checkSkull = skullList_MerkleVerify(proof, leaf);

        if (checkSkull == true) {
            amount = skull_List_Mint_Price * quantity;
        } else if (checkWL == true) {
            amount = 0;
        } else {
            amount = mint_Price * quantity;
        }

        if (checkWL == true) {
            if (_numberMinted(msg.sender) == 1) {
                require(
                    _numberMinted(msg.sender) != 1,
                    "You can only mint 1 NFT"
                );
                // revert You_can_only_mint_1_NFT();
            }
        } else {
            if (quantity + _numberMinted(msg.sender) > MAX_MINTS) {
                require(
                    quantity + _numberMinted(msg.sender) < MAX_MINTS,
                    "You can only mint 2 NFTs"
                );
                // revert You_can_only_mint_2_NFT();
            }
        }

        // if (msg.value < amount) {
        //     revert Not_Enough_Ethers_Sent();
        // }
        require(msg.value >= amount, "Not Enough Ethers Sent");

        // if (block.timestamp < mint_Time) {
        //     revert Mint_Not_Yet_Started();
        // }
        require(block.timestamp >= mint_Time, "Mint Not Yet Started");

        if (msg.sender != owner()) {
            if (checkSkull == true) {
                require(
                    Skull_Mints <= 500,
                    "Not Enough Tokens Left for skullList"
                );
                if (
                    block.timestamp >= Skull_List_Time || totalSupply() >= 1531
                ) {
                    _safeMint(msg.sender, quantity);
                    Skull_Mints += quantity;
                } else {
                    require(
                        totalSupply() >= 2031,
                        "Wait Till Skull List Mint Starts"
                    );
                    require(
                        block.timestamp >= Skull_List_Time,
                        "Wait Till Skull List Mint Starts"
                    );
                    // revert Wait_Till_Skull_Mint_Starts();
                }
            } else if (checkWL == true) {
                require(WL_Mints <= 500, "Not Enough Tokens Left for OG");
                if (
                    block.timestamp >= whiteList_Time || totalSupply() >= 2031
                ) {
                    _safeMint(msg.sender, quantity);
                    WL_Mints += quantity;
                } else {
                    require(totalSupply() >= 2031, "OG mint not started yet.");
                    require(
                        block.timestamp >= whiteList_Time,
                        "OG Still Have Time To Mint"
                    );
                    // revert WhiteListers_Still_Have_Time_To_Mint();
                }
            } else {
                require(
                    Public_Mints < 1500,
                    "Not Enough Tokens Left for public"
                );
                _safeMint(msg.sender, quantity);
                Public_Mints += quantity;
            }
        }
    }

    function whiteList_MerkleVerify(bytes32[] memory proof, bytes32 leaf)
        public
        view
        returns (bool)
    {
        return MerkleProof.verify(proof, whiteList_root, leaf);
    }

    function skullList_MerkleVerify(bytes32[] memory proof, bytes32 leaf)
        public
        view
        returns (bool)
    {
        return MerkleProof.verify(proof, skull_root, leaf);
    }

    function add_WhiteList_Hash(bytes32 _root) public onlyOwner {
        whiteList_root = _root;
    }

    function add_skullList_Hash(bytes32 _root) public onlyOwner {
        skull_root = _root;
    }

    function ChangeOwner(address _OwnerAddress) public onlyOwner {
        OwnerAddress = _OwnerAddress;
    }

    function withdraw() external payable onlyOwner {
        //Developer's stake
        uint256 ds = (address(this).balance * 25) / 100;
        payable(DeveloperAddress).transfer(ds);

        //Owner's stake
        payable(OwnerAddress).transfer(address(this).balance);
    }

    function setTimer(
        uint32 _stamp,
        uint32 _Skull_List_Time,
        uint32 _wl
    ) public onlyOwner {
        mint_Time = _stamp;
        Skull_List_Time = _Skull_List_Time;
        whiteList_Time = _wl;
    }

    ////////////////////////////////
    // Royalty functionality
    ///////////////////////////////

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721A)
        returns (bool)
    {
        return
            interfaceId == 0x2a55205a || super.supportsInterface(interfaceId);
    }

    function royaltyInfo(
        uint256, /*_tokenId */
        uint256 _salePrice
    ) external view returns (address receiver, uint256 royaltyAmount) {
        return (royaltyReceiver, calculateRoyalty(_salePrice));
    }

    function calculateRoyalty(uint256 _salePrice)
        public
        view
        returns (uint256)
    {
        return (_salePrice / 10000) * royaltyFeesInBips;
    }

    function setRoyaltyInfo(address _receiver, uint96 _royaltyFeesInBips)
        public
        onlyOwner
    {
        royaltyReceiver = _receiver;
        royaltyFeesInBips = _royaltyFeesInBips;
    }

    function setContractUri(string calldata _contractURI) public onlyOwner {
        contractURI = _contractURI;
    }

    function setRootHashes(bytes32 _whiteList_root, bytes32 _skull_root)
        public
        onlyOwner
    {
        whiteList_root = _whiteList_root;
        skull_root = _skull_root;
    }

    ///////////////////////////////////////////

    function setStakeAddress(address _developer) public onlyOwner {
        DeveloperAddress = _developer;
        // PartnerAddress = _partner;
    }

    function suppliedNFTs() public view returns (uint256) {
        return totalSupply();
    }

    function userMint() public view returns (uint256) {
        return _numberMinted(msg.sender);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string calldata _baseUri) public onlyOwner {
        baseURI = _baseUri;
    }
}
