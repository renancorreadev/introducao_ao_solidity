// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

  /*
  ------------------- note ---------------------------------------------------
    * Função para Buscar todos endereços financiadores.
    * note: Como iremos buscar valores de um estado e retornar esse valor declaramos a função como view
    * note: @return address[] - Como estamos buscando valores de um array é necessario adicionar memory ou callback 

  
  /** 
      *@dev As diferenças ente public e external são: 
    * public - Função publica visivel - que pode ser acessada por outras funções internas.
    * external - Função publica externa - que nao podem ser acessadas por outras funções internas. 
    * Boa pratica é analisar se a funcao publica será usada por outras funções internas. 
    */

    /**
    *@dev Faça os testes no Truffle console
    * const contract = await Faucet.deployed()
    * contract.addFundos({ from: accounts[1], value: "10000"})
    * contract.getFundadoresAtIndex(1)
    */

contract Faucet {
   

    //Array de endereços

    uint public numerodeFinanciadores;
    mapping(uint => address) private patrocinadores; 

    uint256 public founds = 1000;

    receive() external payable {}
    /*
      * Função para adicionar Fundos.
      * @param financiadores - Adiciona o endereço que adicionou fundos para um array de endereço denominado financiadores.
    /*/
    function addFundos() external payable {
      uint index  = numerodeFinanciadores++;
      patrocinadores[index] = msg.sender;
    }

    /**
      * @dev função para retornar todos patrocinadores adicionados na funcao addFundos()
     */
    function getTodosPatrocinadores() external view returns(address [] memory) {
      /**@dev esse modelo de declaração abaixo esta sendo bastante utilizado atualmente para reduzir custos de gas */
       address [] memory _patrocinadores = new address [](numerodeFinanciadores);
          /** Iteração percorrendo numeroFinanciadores e relacionando ao array patrocinadores[]  */
       for (uint i=0; i<numerodeFinanciadores; i++) {
          _patrocinadores[i] = patrocinadores[i];
       }
       return _patrocinadores;
    }

    function getFundadoresAtIndex(uint8 index) external view returns(address) {
      return patrocinadores[index];
    }

    /**
      @dev Diferecncias entre private e internal
      private - Acessivel apenas no contrato 
      internal - So pode ser acessivel atraves de um contrato inteligente ou derivado de outros contratos inteligents

      * note: PRIVATE => Rigoroso, apenas acessivel para variaveis e funcoes. 
      
     */
}