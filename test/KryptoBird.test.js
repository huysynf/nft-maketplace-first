const chai = require('chai');
const assert = chai.assert;

const KryptoBird = artifacts.require('KryptoBird');

// 

require('chai')
    .use(require('chai-as-promised'))
    .should()

contract('KryptoBird', async(accounts) => {
    // let contract = await KryptoBird.deployed()

    // testing container 

    describe('deployment', async() => {
        /// test 

        it('deploy successfully', async() => {
            let contract = await KryptoBird.deployed()
            const address = contract.address;
            assert.notEqual(address, '');
            assert.notEqual(address, 'null')
            assert.notEqual(address, null)
        })
    })
})