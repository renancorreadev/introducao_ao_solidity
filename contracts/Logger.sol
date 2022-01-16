// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

/**
    @notice Quando as funções não possui implementação para serem reutilizadas em outro ponto
    do codigo usamos o virtual e para usar em outra função usamos o override... 
 */
abstract contract Logger {
    function emitLog() public virtual pure returns(bytes32);
}