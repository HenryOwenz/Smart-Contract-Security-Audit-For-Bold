pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";

contract FungiToken is ERC1155, Ownable {

    uint256 public MAX_QUANTITY = 5000;
    uint256 public MINT_PRICE = 0.1 ether;
    uint256 public MINT_WALLET_MAX = 5;
    uint256 public TOKENID = 1;
    uint256 public mintCount;

    mapping(address => uint256) public walletMintCount;

    constructor() ERC1155('uri') {}

    function mint() external payable {
        require(msg.sender == tx.origin, 'NO_CONTRACTS');
        require(walletMintCount(msg.sender) < MINT_WALLET_MAX, 'MINT_LIMIT_EXCEEDED');
        require(mintCount < MAX_QUANTITY, 'SOLD_OUT');
        _mint(msg.sender, TOKENID, 1, '');
        walletMintCount(msg.sender) += 1;
        mintCount += 1;
    }
}

