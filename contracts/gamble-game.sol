pragma solidity ^0.5.0;

contract GambleFactory{
	event newGambleContractCreated(
		address _host, string _gambleName);

	function createGambleContract (string memory _gambleName, uint _costToEnter) public payable{
		require (msg.value == _costToEnter);
		Gamble newGamble = (new Gamble).value(_costToEnter)(_costToEnter, msg.sender);
		emit newGambleContractCreated(msg.sender, _gambleName);
	}
}

contract Gamble {
	constructor (uint _costToEnter, address _host) public payable {
        setGameAddresses(_host);
        setCostToEnter(_costToEnter);
    }
	address host;
	address player;
	uint costToEnter;

	modifier onlyHost {
		require (msg.sender == host);
		_;
	}

	function setGameAddresses (address _host) private {
		host = _host;
		player = 0x0000000000000000000000000000000000000000;
	}

	function setCostToEnter(uint _costToEnter) private {
		costToEnter = _costToEnter;
	}

	function joinGame() public payable {
		require (player == 0x0000000000000000000000000000000000000000);
		require (msg.value == costToEnter);
		player = msg.sender;
	}

	function startGame() public payable onlyHost {
		require (player != 0x0000000000000000000000000000000000000000);

		// randomness to determine winner - current implementation is insecure
		uint winner = uint(keccak256(abi.encodePacked(now, msg.sender))) % 2;


		if (winner == 1){
			// can't figure out why there's a bug here
			address(host).transfer(address(this).balance);
		}
		else {
		    player.transfer(address(this).balance);
		}

	}

	function getCostToEnter() public view returns (uint) {
		return costToEnter;
	}
}