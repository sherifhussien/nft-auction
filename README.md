# Non Fungible Token Auction

 A simple NFT auction contract where a seller can put up his NFT for auction, buyers bid for it, and after the auction period ends, the NFT ownership gets transferred to the address of the highest bidder and the bid value is deposited to the seller’s account.

Run the following task to start up a blockchain locally:

```shell
npm install
npx hardhat node
```

Run the following tasks to deploy your contracts locally:

```shell
npx hardhat compile
npx hardhat run scripts/deploy.js --network localhost
```
