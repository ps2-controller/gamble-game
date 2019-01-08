pragma solidity ^0.5.0;
import "./ gamble-game.sol"

contract GambleFactory{

	Gamble[] gambleGames;
	mapping(address => address) gambles;
	mapping(address => Gamble[]) gambleGamesByHost;
	mapping(address => Gamble[]) gambleGamesByPlayer;

	event newGambleContractCreated(
		address _host, string _gambleName);

	function createGambleContract (string memory _gambleName, uint _costToEnter) public payable{
		require (msg.value == _costToEnter);
		gambles[msg.sender] = (new Gamble).value(_costToEnter)(_costToEnter, msg.sender);
		gambleGames.push(newGamble);
		emit newGambleContractCreated(msg.sender, _gambleName);
	}
}
