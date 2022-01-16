// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "./Owned.sol";
import "./Logger.sol";
import "./IFaucet.sol";

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

    /**
      * @dev funções sem implementacões para reutilizacao podem ser declaradas como virtual
      * e funções que reescrevem a mesma função sem implementação podem ser declarada como override
      *note: funções que tem apenas um retorno de valor sem nenhum estado devem ser declaradas como pure.
     */

     /** 
      *note: Para criar uma função em um contract e chamar essa mesma função em 
      um outro contrato especifico as funções devem ser declaradas com internal ou public na
       no contrato A (onde esta implementada) e override no contrato B (onde sera reutilizado) 
      */


contract Faucet is Owned, Logger, IFaucet {
   
    //Array de endereços

    uint public numerodeFinanciadores;
    uint256 public maxFundos = 1*10**18;
   

    mapping(address => bool) private patrocinadores; 
    mapping(uint => address) private lutPatrocinadores; 

    /** 
      *@dev modificadores são usados para reaproveitar condições de um contrato. (require) ou ifs
     */
    modifier limitwithdraw(uint256 amount ){
        require(amount < maxFundos, "Quantidade excedida ao limite");
        //underscore é usado para não ser acessado diretamente
        _;
    }

    
    receive() external payable {}
    /*
      * Função para adicionar Fundos.
      * @param financiadores - Adiciona o endereço que adicionou fundos para um array de endereço denominado financiadores.
    /*/

    function emitLog() public override pure returns(bytes32){
      return "Hello";
    }

    /** 
      * @dev funções sobrescritas das interfaces necessitam ser override e implementar a função
     */
    function addFundos() override external payable {
      address patrocinador = msg.sender;
      if(!patrocinadores[patrocinador]){
        uint index = numerodeFinanciadores++;
        patrocinadores[patrocinador] = true;
        lutPatrocinadores[index] = msg.sender;
      }
    }

    function withdraw(uint amount) override external limitwithdraw(amount)  {
      payable(msg.sender).transfer(amount);
    }
    /**
      * @dev função para retornar todos patrocinadores adicionados na funcao addFundos()
     */
    function getTodosPatrocinadores() external view returns(address [] memory) {
   
       address [] memory _patrocinadores = new address [](numerodeFinanciadores);

       for (uint i=0; i<numerodeFinanciadores; i++) {
          _patrocinadores[i] = lutPatrocinadores[i];
       }

       return _patrocinadores;
    }

    function getFundadoresAtIndex(uint8 index) external view returns(address) {
      return lutPatrocinadores[index];
    }

    function transferOwnership(address newOwner) external onlyOwner {
      owner = newOwner;
    }

    /**
      @dev Diferecncias entre private e internal
      private - Acessivel apenas no contrato 
      internal - So pode ser acessivel atraves de um contrato inteligente ou derivado de outros contratos inteligents

      *note: PRIVATE => Rigoroso, apenas acessivel para variaveis e funcoes. 
     */
}