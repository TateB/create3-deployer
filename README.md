## CREATE3 Deployer

A minimal factory that deploys contracts deterministically using Solady's `CREATE3` library. It provides a single contract, `CREATE3Deployer`, exposing:

- `deployDeterministic(bytes initCode, bytes32 salt) returns (address)`
- `predictDeterministicAddress(address deployer, bytes32 salt) view returns (address)`

The salt is hashed with the caller address for deployment, giving each deployer its own namespace. The predicted address must be computed with the same `deployer` address that will call `deployDeterministic`.

### Build and Test

Requires [Foundry](https://book.getfoundry.sh) to run.

```sh
forge build
forge test
```

### Deploy the Factory

Anyone can deploy the factory on any network, assuming it has the deterministic deployer already deployed at `0x4e59b44847b379578588920cA78FbF26c0B4956C`.

```sh
forge script script/CREATE3Deployer.s.sol:Deploy \
  --rpc-url $RPC_URL \
  --broadcast
```

On success, the factory will be at `0x004eE012d77C5D0e67D861041D11824f51B590fb`.

### Acknowledgements

- Uses Solady `CREATE3` library.
