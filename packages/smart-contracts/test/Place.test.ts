import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { expect } from 'chai';
import { Contract, ContractFactory } from 'ethers';
import { ethers } from 'hardhat';

const { getSigners, utils } = ethers;

describe('Place', () => {
  let wallet0: SignerWithAddress;
  let wallet1: SignerWithAddress;
  let wallet2: SignerWithAddress;
  let Place: Contract;
  let PlaceDeployer: ContractFactory;

  const name = 'Place';
  const symbol = 'PLACE';
  const price = '0';
  const imageURI = 'ipfs://';

  const contactInformation = {
    name: 'Place',
    description: 'A beautiful place in the Ethereal',
    image: 'ipfs://QmR1tCdArDcAKmCJezMhZxRGqfxhMdTHmGJZAhtriFa41t',
    externalLink: 'https://places.kames.me',
    sellerFeeBasisPoints: '0',
    feeRecipient: '0x0000000000000000000000000000000000000000',
  };

  before(async () => {
    [wallet0, wallet1, wallet2] = await getSigners();
    PlaceDeployer = await ethers.getContractFactory('Place');
  });

  beforeEach(async () => {
    Place = await PlaceDeployer.deploy(
      name,
      symbol,
      imageURI,
      price,
      wallet0.address,
      contactInformation,
    );
  });

  describe('mint(address to, uint256 amount)', () => {
    it('should SUCCEED to MINT place', async () => {
      await Place.mint(wallet0.address);
      expect(await Place.balanceOf(wallet0.address)).to.be.equal(1);
    });
  });
});
