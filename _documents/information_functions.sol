// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Information {
    //storage variables 

    uint256 public founds = 1000;
   /*
     * @devs se seu contrato precisa receber pagamentos é necessario essa função especial 
     que é chamada quando o contrato recebe um tx sem especificar o nome de uma função
    */
    receive() external payable {}

    /* 
    * NOTE:
    * Uso do console truffle 
    const instance = new web3.eth.Contract(Faucet.abi, "0xe4A2f46324d6b932D7C7815618542a6a9c0518ce")
    instnciar uma nova instancia do contrato

    const fundos = await instance.methods.founds().call(); 
    chamada callback para funcao publica founds 

    web3.eth.sendTransaction({
       from: accounts[0], to: "0xe4A2f46324d6b932D7C7815618542a6a9c0518ce", 
       value:"3000000000000000000"}
       );
     - enviando 3 ethers para o contrato...
    */

    function addFundos() external payable {}
    // external - chamadas de funções de escrita (necessita pagar taxa de mineração)

    function justTesting() external pure {

    }

    /* 
      NOTE:
      * view funções podem ler variáveis ​​de estado e globais. 
      * pure funções não podem ler nem estado nem variáveis ​​globais.
      * @TODO Todas transaçoes que requerem alterar estados (view) requerem taxa de gás
      * Todas funções de leitura onde não altera nenhum estado (pure) não requerem taxa de gás, free! 
    */
    
}