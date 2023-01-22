# SkillChain - A DApp designed for verifying skill certificates that are not mutable, protected by cryptography, and always available.


Installation & Set Up
First step is to add metamask plugin to your supported browser (chrome) from this link [here](https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?hl=en) and login

Please pay close attention to the instructions provided. There may be problems with installing certain packages if they are not well-maintained. If you encounter any issues during the installation process, you can check some developer communities for help or reach out to me.

Next step is to download the repository. You can clone directly from github with the command: git clone {repo link}

cd skillchain

## Set up Blockchain on Local Network

There are two ways to set up local blockchain with Truffle Ganache, either with GUI or CLI. In this illustration, we will use the GUI method.

> But before we move to that, do these first:

1. Create a `.env` file

Fill in the following environment variables:

```
LOCAL_ENDPOINT=http://127.0.0.1:7545
NETWORK_ID=5777
```

> The Local endpoint and network ID can be changed to your preference and to what you have when you create a workspace on Ganache

> An example `.env.example` file has been created to guide you. You can copy and paste the contents of the file and edit the variables.

2. Download Truffle

Visit https://www.trufflesuite.com/truffle for more information

```bash
npm install -g truffle
```

> Truffle assists us in tasks such as deploying, testing, and migrating.

3. Install node dependencies

```bash
npm install
```

Okay, back to Ganache
Using Ganache GUI, do the following:

1. Download Ganache GUI

Visit [Truffle Ganache](https://www.trufflesuite.com/ganache) to download the application

2. Create a ganache workspace & run ganache blockchain network

To create a new workspace project with the same truffle settings defined in the truffle-config.js file, click on 'New Workspace' and then under 'Add Project', select the truffle-config.js file from the Skillchain directory.

![](https://i.imgur.com/gnWVdrN.png)


When the workspace is open, the local ganache blockchain network should be active on the specified port and network ID.

> Note: Keep the workspace open so that it will run while working on your project

3. Deploy Smart Contracts

To make contract deployment easier, npm scripts have been added. You can see the commands used by looking at the package.json file for further clarification.

In the root directory of SKillchain, run the following commands one after the other:

```bash
truffle compile
npm run deploy:local
```

### Setting up Blockchain on Ethereum Goerli Test Network

For our application, we will be running it on the Goerli test network, feel free to use other test networks like Ropsten, just change the settings accordingly.

#### Getting ether on Goerli

Before you are able to deploy the smart contracts, you will need some ether in your account first. Visit the [Goerli faucet](https://goerlifaucet.com/) and follow the instructions on the page to get some ether transferred to your account. You will be propmted to create an account on Alchemy platform.

#### Deploying Smart Contracts

We will use Infura to help us deploy easily on our development set up with truffle.
Go to [Infura](https://infura.io/) to create an ethereum project. Click on Create New Key, choose Web3 API as the Network option. When the project is created, click on endpoints, scroll down to `Ethereum L1 Blockchain` and change the 'endpoints' to Goerli, then copy the endpoint link for the environment variables below.  
For the mnemonic, use your metamask account mneumonic.

```
PROJECT_ENDPOINT=https://goerli.infura.io/v3/<endpoint>
MNEMONIC="<your account's mnemonic with the ether on rinkeby>"
```

Connect to the Goerli test network in your metamask and then, deploy the smart contracts.

```bash
npm run deploy:testnet
```

> Another option is to use the [Ethereum's Remix](https://remix.ethereum.org/) for smart contract development and deployment as well, without using Infura.

> However, keep in mind that we will be using Infura on our client application as well, and will reuse this endpoint.

### Let's set up Frontend Application

The Frontend application (which is built with [React.js](https://reactjs.org/)) is located under the `/client` folder in the directory.

```bash
cd client
```

1. Install dependencies

```bash
npm install
```

2. Create a `.env`file

Populate the following environment variables:

```
REACT_APP_INFURA_PROJECT_ENDPOINT=https://goerli.infura.io/v3/<endpoint>
REACT_APP_LOCAL_ENDPOINT=http://127.0.0.1:7545
REACT_APP_NETWORK_ID=5777
```

> Again, the port number and network ID can be changed to your preference
> Use the same Infura project endpoint with instructions given above

> You can copy and paste the contents of an `.env.example` file created in that directory and edit the variables.

3. Start application

### Option 1 - Let's connect to local blockchain

```bash
npm start
```

To use the front-end application running at http://localhost:3000/, connect to the Localhost Network in metamask

You should see a Localhost:7545 on your MetaMask account networks

Import the account that was used to deploy the contracts, to do this, use the private key of the account, it can be found in the key symbol of the Ganache UI next to your account.

![](https://i.imgur.com/f090jmt.png)

### Option 2 - To connect to Rinkeby test network

```bash
npm run start:testnet
```

To use the front-end application running at http://localhost:3000/, connect to the Goerli Test Network in metamask and use the account that you used to deploy the contracts.



> This will connect to the Goerli network with Infura, only for viewing of certificates. The other functions uses the Ethereum-based browsers (connected to Metamask wallets) to access the network.

---

## Security & Testing

### Smart Contracts Funtionality Testing

This will run the testing files with the test cases defined the files, located under `/test` folder
Make sure the local ganache blockchain network is running first before testing. Testing will be done on the local network.

```bash
truffle test
```

> If these test cases pass, you are good. If not, please double check the local blockchain network is set up correctly (especially the Port number and network ID)

### Smart Contracts Security Testing & Analysis

We are using Mythrill to conduct security analysis of our Smart Contracts - `Institutions.sol` and `Certification.sol`.
This will be run on Docker images, so make sure you have [Docker](https://www.docker.com/) on your machine.

```bash
# Set up
docker pull mythril/myth
docker run mythril/myth --help
docker run mythril/myth disassemble -c "0x6060"

# Mounting and Running analysis on Smart Contracts
docker run -v %(cd)%:/contracts mythril/myth analyze /contracts/Institutions.sol
docker run -v %(cd)%:/contracts mythril/myth analyze /contracts/Certification.sol
```

> Refer to the [Mythrill documentation](https://mythril-classic.readthedocs.io/en/master/installation.html) if you need instructions running on other OS

---

## Finished project

You are welcome to visit the live website connected to the Ethereum Goerli network at https://skillchain.vercel.app/ 😁


## Team Members

- [Peculiar Richard](https://github.com/peculiarrichard)
- [Michael Adesina](https://github.com/m-azra3l)
- [Egar King David](https://github.com/KingDavid9991)
- [Folayowon Oladapo](https://github.com/folayowon)
