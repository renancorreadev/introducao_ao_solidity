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
    uint256 public maxFundos = 1*10**18;
    address public owner;

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

    modifier onlyOwner(){
        require(
          msg.sender == owner, 
          "Somente o dono pode executar"
          );
        _;
    }

    receive() external payable {}
    /*
      * Função para adicionar Fundos.
      * @param financiadores - Adiciona o endereço que adicionou fundos para um array de endereço denominado financiadores.
    /*/
    function addFundos() external payable {
      address patrocinador = msg.sender;
      if(!patrocinadores[patrocinador]){
        uint index = numerodeFinanciadores++;
        patrocinadores[patrocinador] = true;
        lutPatrocinadores[index] = msg.sender;
      }
    }

    function withdraw(uint amount) external limitwithdraw(amount)  {
     
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



    /**
      @dev Diferecncias entre private e internal
      private - Acessivel apenas no contrato 
      internal - So pode ser acessivel atraves de um contrato inteligente ou derivado de outros contratos inteligents

      *note: PRIVATE => Rigoroso, apenas acessivel para variaveis e funcoes. 
     */
}