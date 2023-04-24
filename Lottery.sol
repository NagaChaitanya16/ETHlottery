//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Lottery{

          address payable[] public players;
          address public manager;
          
          
          constructor(){
                          manager = msg.sender;                         
                        }   
                        
    receive() external payable{
              
              require(msg.value==0.1 ether, "Only 0.1ETH is allowed to send");
           
              players.push(payable(msg.sender));
          }

    function getBal() public view returns(uint){
              require(msg.sender==manager, "Only admin can view the balance");
              return address(this).balance;
          }

     function random() public view returns(uint){

             return uint(keccak256((abi.encodePacked(block.timestamp, players.length))));
          }
             address  payable  winner;

     function pickWinner() public{

              require(msg.sender==manager);
              require(players.length >= 3);       //100000000000000000

              uint r=random();
            
              uint index = r % players.length;

              winner = players[index];

              uint adminFee = (getBal()*10)/100;
              uint winnerPrize = (getBal()*90)/100;

              winner.transfer(winnerPrize);
              payable(manager).transfer(adminFee);

              players= new address payable[](0);                     
             
          }

    function addrofWinner() public view returns(address){
                    
                     return winner;                  

          }
}