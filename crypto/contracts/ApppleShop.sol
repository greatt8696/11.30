// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract AppleShop {
    // address 속성명, uint 속성값, myApple 변수명의 객체
    mapping(address => uint8) myApple;
    // payable 속성이 있을때 CA 는 ETH 를 받을 수 있다.
    // 트랜잭션 객체에 value 값을 ETH 로 전달할 수 있다.
    // 사과 구매 함수
    // 갯수
    event buyEvent(string name, uint8 _quantity, uint8 _myApple);
    event sellEvent(string name, uint8 _quantity, uint8 _myApple);

    mapping(string => mapping(address => uint8)) myFruits;

    mapping(string => uint256) fruitsPrice;

    string[] fruitsName;

    constructor() {
        fruitsPrice["apple"] = 0.1 ether;
        fruitsPrice["banana"] = 0.2 ether;
        fruitsPrice["watermelon"] = 0.3 ether;
        fruitsPrice["gimchi"] = 0.4 ether;
    }

    function setFruitPrice(string memory name, uint256 price)
        public
        returns (bool)
    {
        fruitsPrice[name] = price;
        return true;
    }

    function getFruitsName() public view returns (string[] memory) {
        return fruitsName;
    }

    function addFruitsName(string memory fruit) public {
        fruitsName.push(fruit);
    }

    function buyApple(string memory name, uint8 quantity) public payable {
        myFruits[name][msg.sender] += quantity;
        uint256 buyValue = fruitsPrice[name] * quantity;
        // payable().transfer(buyValue);
        emit buyEvent(name, quantity, myApple[msg.sender]);
    }

    // 사과 전체 판매 함수
    function sellApple(string memory name, uint8 quantity) public payable {
        myFruits[name][msg.sender] += quantity;
        uint256 refund = fruitsPrice[name] * quantity;
        myApple[msg.sender] -= quantity;
        // payable 함수의 매개변수로 주소를 전달해 준다.
        // 전달한 주소의 계정에 돈을 보내줌
        // 보내주는 돈은 사과의 갯수
        // payable(msg.sender).transfer(refund);
        emit sellEvent(name, quantity, myApple[msg.sender]);
    }

    // 가지고 있는 사과 확인 함수
    function getMyFruits() public view returns (uint256[] memory) {
        uint256[] memory result;
        for (uint256 idx = 0; idx < fruitsName.length; idx++) {
            result.push(myFruits[fruitsName[idx]][msg.sender]);
        }
        return result;
    }
}
