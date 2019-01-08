pragma solidity ^0.5.0;
import "./ gamble-game.sol"

contract GambleFactory{
	event newGambleContractCreated(
		address _host, string _gambleName);

	function createGambleContract (string memory _gambleName, uint _costToEnter) public payable{
		require (msg.value == _costToEnter);
		Gamble newGamble = (new Gamble).value(_costToEnter)(_costToEnter, msg.sender);
		emit newGambleContractCreated(msg.sender, _gambleName);
	}
}
