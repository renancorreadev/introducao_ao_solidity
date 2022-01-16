const { assert } = require('chai')

const Faucet = artifacts.require('Faucet')

require('chai').use(require('chai-as-promised')).should()

contract('Faucet', (accounts) => {
  let faucet
  let valueEth = '100000000000000000'

  const address1 = accounts[1]
  const address2 = accounts[2]
  const address3 = accounts[3]
  const address4 = accounts[4]

  const addressFounders = [address1, address2, address3, address4]

  const owner = accounts[0]

  before(async () => {
    // Load Contracts
    faucet = await Faucet.new()
  })

  describe('Deployment of Faucet', () => {
    it('should name of contract', async () => {
      const name = await faucet.name()
      assert.equal(name, 'Faucet')
    })
  })

  describe('Add founds on the contract', () => {
    it('should add found to contract address', async () => {
      result1 = await faucet.addFundos({
        from: address1,
        value: web3.utils.toWei('1', 'ether'),
      })
      result2 = await faucet.addFundos({
        from: address2,
        value: web3.utils.toWei('1', 'ether'),
      })
      result3 = await faucet.addFundos({
        from: address3,
        value: web3.utils.toWei('1', 'ether'),
      })
      result4 = await faucet.addFundos({
        from: address4,
        value: web3.utils.toWei('1', 'ether'),
      })
    })
  })

  describe('Withdraw founds', () => {
    it('Verify max for withdraw', async () => {
      await faucet.withdraw(valueEth)
    })
  })

  describe('Testando a busca por todos patrocinadores', () => {
    it('Verificar função getTodosPatrocinadores()', async () => {
      const result = await faucet.getTodosPatrocinadores()
      /** @dev como foi adicionado 4 endereços estamos fazendo esse teste com 4 */
      assert.equal(result.length, 4)
    })
  })

  describe('Testando Owner - proprietario', () => {
    it('Comparando o endereço 0x0..', async () => {
      const result = await faucet.owner()
      assert.equal(result, owner)
    })
  })

  describe('Testando busca de Patrocinadores por index', () => {
    it('Verificando endereço pelo getFundadoresAtIndex()', (done) => {
      faucet
        .getFundadoresAtIndex(2)
        .then((result) => {
          if (
            result == addressFounders[1] ||
            result == addressFounders[2] ||
            result == addressFounders[3] ||
            result == addressFounders[4]
          ) {
            assert.isOk('Esse endereco é um Patrocinador!')
          } else {
            assert.isNotOk('Esse endereco não é um Patrocinador!')
          }
          done()
        })
        .catch(done)
    })
  })

  describe('Testando transferencia OwnerShip', () => {
    it('Verificando transferencia OwnerShip', async () => {
      const NewAddress = '0xe7204B2f035fbDcd1ECFE834Fc5d6E2508fc8e23'
      await faucet.transferOwnership(NewAddress).then(async () => {
        const result = await faucet.owner()
        assert.equal(result, NewAddress)
      })
    })
  })
})
