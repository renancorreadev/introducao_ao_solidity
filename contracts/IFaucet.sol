// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

/** 
    *@dev Todas funçoes de uma interface devem ser external    
    note As interfaces nao podem herdar funcionaldiades de outros contratos apenas de 
    outras interfaces...

    @dev Interfaces nao podem: <0
    * declarar variaveis de estado 
    * declarar um construtor 
    * funcoes tem que ser externas
 */
interface IFaucet{
    function addFundos() external payable; 
    function withdraw(uint amount) external;
}