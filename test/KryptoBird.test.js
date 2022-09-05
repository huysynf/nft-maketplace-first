const chai = require('chai');
const assert = chai.assert;

const KryptoBird = artifacts.require('KryptoBird');

// 

require('chai')
    .use(require('chai-as-promised'))
    .should()

contract('KryptoBird', async(accounts) => {
    let contract;
    before(async() => {
            contract = await KryptoBird.deployed();
        })
        // testing container 

    describe('deployment', async() => {
        /// test 
        it('deploy successfully', async() => {
            const address = contract.address;
            assert.notEqual(address, '');
            assert.notEqual(address, 'null')
            assert.notEqual(address, null)
        })

        it('has a name', async() => {
            const name = await contract.name()
            assert.equal(name, 'KryptoBird')
        })

        it('has a symbol', async() => {
            const name = await contract.symbol()
            assert.equal(name, 'KBIRD')
        })
    })

    describe('minting', async() => {
        it('create a new token', async() => {
            const result = await contract.mint('http...1')
            const totalSupply = await contract.totalSupply();
            // success
            assert.equal(totalSupply, 1);
            const event = result.logs[0].args;
            assert.equal(event._from, '0x0000000000000000000000000000000000000000', 'from contact')
            assert.equal(event._to, accounts[0], "to mes.sender")

            // faile
            await contract.mint('http...1').should.be.rejected;

        })
    })

    describe('indexing', async() => {
        it('lists KryptoBird', async() => {
            await contract.mint('http...2')
            await contract.mint('http...3')
            await contract.mint('http...4')

            const totalSupply = await contract.totalSupply();

            let result = [];
            let KryptoBirdz
            for (let index = 0; index < totalSupply; index++) {
                KryptoBirdz = await contract.kryptoBirdz(index - 1)
                result.push(KryptoBirdz);
            }

            let expects = ['http...1', 'http...2', 'http...3', 'http...4']
            assert.equal(result.join(','), expects.join(','))
        })

    })
})