//**
* @notice This is pragma version.
*/
pragma solidity >=0.5.0 <0.6.0; 

//** 
* @title ZombieFactory 
* @param NewZombie calls program to run. 
*/
contract ZombieFactory { 
    event NewZombie(uint zombieId, string name, uint dna); 

    //**
    * @notice The number will have 16 digits.
    * @notice It will make sure that the number has really 16 digits.
    */
    uint dnaDigits = 16;    
    uint dnaModulus = 10 ** dnaDigits; 

    //** 
    * @param Zombie is like a map where:
    * @param string is a word.
    * @param uint is a number.
    */
    struct Zombie {    
        string name;   
        uint dna;      
    }

    //**
    * @dev With arrayys we do indexing of zombies. 
    */
    Zombie[] public zombies;

    //**
    * @param Uint will be mapped to the address.        //->Tukaj ostal. 
    * @param Address will be mapped to a number. 
    */
    mapping (uint => address) public zombieToOwner; 
    mapping (address => uint) ownerZombieCount;    

    //**
    * @dev Function createZombie with arguments _name, _dna is private and only this contract, program can call it. 
    * @dev uint id is the field that create a new zombie with _name, _dna and if the lenght of array becomes 1, it will be taken to index 0.  
    * @dev zombieToOwner saves the ownership of id to the msg.sender. 
    * @param The ++ adds the new zombie to the sender who owns the zombies. 
    * @param Emit this information on blockchain where is readable to others eg. file.js. 
    */
    function _createZombie(string memory _name, uint _dna) private {    
        uint id = zombies.push(Zombie(_name, _dna)) - 1;       
        zombieToOwner[id] = msg.sender; 
        ownerZombieCount[msg.sender]++;    
        emit NewZombie(id, _name, _dna);   
    }

    //**
    * @param _generateRandomDna does zero change on blockchain, only readable within the contract. Returns the name that the user types.
    * @param Variable rand stores variable of a big number that converts result of calculation of SHA-3 (256-bits number or 32 bytes). 
    * @param Operation modulus, %, returns variable rand limites to dnaModulus number of digits (dnaModulus is defined at the beginning). 
    */
    function _generateRandomDna(string memory _str) private view returns (uint) {    
        uint rand = uint(keccak256(abi.encodePacked(_str)));  
        return rand % dnaModulus;    
    }

    //**
    * @param Function createRandomZombie when user types name of the zombie this function is readable to anyone with Eth address.
    * @param Function requires that the zombies count of the owner who is the sender starts with 0, or function does not call functions. 
    * @dev It calls the function generateRandomDna calculates based on the typed name the number and stores it in randDna.
    * @dev It calls the second function that addds the new zombie to the ___, sets the ownership and rises the number of user zombies and starts the event. 
    */
    function createRandomZombie(string memory _name) public {    
        require(ownerZombieCount[msg.sender] == 0);      
        uint randDna = _generateRandomDna(_name);    
        _createZombie(_name, randDna);    
    }

}








