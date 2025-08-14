## CREATE3 Deployer

A minimal factory that deploys contracts deterministically using Solady's `CREATE3` library. It provides a single contract, `CREATE3Deployer`, exposing:

- `deployDeterministic(bytes initCode, bytes32 salt) returns (address)`
- `predictDeterministicAddress(address deployer, bytes32 salt) view returns (address)`

The salt is hashed with the caller address for deployment, giving each deployer its own namespace. The predicted address must be computed with the same `deployer` address that will call `deployDeterministic`.

### Supported Chains

All supported chains have `CREATE3Deployer` deployed to `0x000000000004d4f168daE7DB3C610F408eE22F57`:

#### Mainnet Chains

- Ethereum `1`
- Optimism `10`
- Base `8453`
- Arbitrum One `42161`
- Linea `59144`
- Scroll `534352`

#### Active Testnet Chains

- Holesky `17000`
- Linea Sepolia `59141`
- Base Sepolia `84532`
- Arbitrum Sepolia `421614`
- Scroll Sepolia `534351`
- Sepolia `11155111`
- Optimism Sepolia `11155420`

### Deploy the Factory

Anyone can deploy the factory on any network, assuming it has the deterministic deployer already deployed at `0x4e59b44847b379578588920cA78FbF26c0B4956C`.

```sh
forge script script/CREATE3Deployer.s.sol:Deploy \
  --rpc-url $RPC_URL \
  --broadcast
```

On success, the factory will be at `0x000000000004d4f168daE7DB3C610F408eE22F57`.

### Build and Test

Requires [Foundry](https://book.getfoundry.sh) to run.

```sh
forge build
forge test
```

### Acknowledgements

- Uses Solady `CREATE3` library.
- Originally based on [create3-factory](https://github.com/ZeframLou/create3-factory)
