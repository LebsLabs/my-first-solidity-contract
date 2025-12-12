pragma solidity >=0.5.0 <0.6.0; //version of pragma

contract ZombieFactory { //program

    event NewZombie(uint zombieId, string name, uint dna); //call the program to run

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits; //making sure that the number has 16 digits

    struct Zombie {
        string name;    //string = word
        uint dna;       //uint = number, variable
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[msg.sender] = id; 
        uint id = ++; // start here
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}

