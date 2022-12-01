// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17.0;

contract Shop {
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
        _owner = msg.sender;
        _exchangePool[strToHash("ETH")] = coinPool("ETH", 1000);
    }

    //  Token 시작  //

    struct coinPool {
        string name;
        uint256 exchangeRate;
    }

    address private _owner;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    mapping(address => uint256) private _balances;
    mapping(bytes32 => coinPool) private _exchangePool;

    modifier onlyOwner() {
        require(_owner == msg.sender, "not Owner");
        _;
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        return true;
    }

    function _mint(address account, uint256 amount) internal returns (bool) {
        _balances[account] += amount;
        _totalSupply += amount;
        return true;
    }

    function mint(address account, uint256 amount)
        public
        onlyOwner
        returns (bool)
    {
        _mint(account, amount);
        return true;
    }

    function strToHash(string memory input) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(input));
    }

    function balacneOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function exchange(string memory exchangeSymbol, uint256 exchangeAmount)
        public
        payable
        returns (bool)
    {
        require(!(strToHash(exchangeSymbol) == strToHash("ETH")), "NOT ETH");
        address payable owner = payable(_owner);
        require(owner.send(msg.value));
        uint256 tokenAmount = _exchangePool[strToHash("ETH")].exchangeRate *
            exchangeAmount;
        _mint(msg.sender, tokenAmount);
        return true;
    }

    function burn(uint256 amount) public onlyOwner returns (bool) {
        _balances[msg.sender] -= amount;
        _balances[address(0)] += amount;
        _totalSupply -= amount;
        return true;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public pure returns (uint8) {
        return 3;
    }

    //  Shop 시작  //

    mapping(address => mapping(string => uint256)) private _myFruits;
    mapping(string => bool) private _fruitsNameExist;
    mapping(string => uint256) private _fruitsPrice;
    string[] public fruitsLabel;

    function addFruit(string memory fruitName, uint256 price)
        public
        returns (bool)
    {
        //check isExist fruitsNameExist
        require(!_fruitsNameExist[fruitName], "already exist fruitName");

        //update state
        _fruitsNameExist[fruitName] = true;
        _fruitsPrice[fruitName] = price;
        fruitsLabel.push(fruitName);

        return true;
    }

    function addBatchFruits(
        string[] memory fruitsName_,
        uint256[] memory fruitsPrice_
    ) public returns (bool) {
        //check isExist fruitsNameExist
        for (uint256 i = 0; i < fruitsLabel.length; i++) {
            require(
                !_fruitsNameExist[fruitsName_[i]],
                "already exist fruitsName"
            );
        }

        //update state
        for (uint256 i = 0; i < fruitsLabel.length; i++) {
            _fruitsNameExist[fruitsName_[i]] = true;
            _fruitsPrice[fruitsName_[i]] = fruitsPrice_[i];
            fruitsLabel.push(fruitsName_[i]);
        }

        return true;
    }
}
