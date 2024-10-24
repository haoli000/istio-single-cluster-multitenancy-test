
# Istio Multi-Control Planes for Multitenancy in Single Cluster Test

This repository contains installation and tests for validating multiple Istio control planes running in a single Kubernetes cluster, using Helm installation. It aims to ensure that different control planes can coexist and function correctly in a multitenant environment.

## Table of Contents

- [Istio Multi-Control Planes for Multitenancy in Single Cluster Test](#istio-multi-control-planes-for-multitenancy-in-single-cluster-test)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
    - [Kind](#kind)
  - [Installation](#installation)
    - [Setting Up the Cluster](#setting-up-the-cluster)
  - [Directory Structure](#directory-structure)
  - [Usage](#usage)
  - [Tests](#tests)
  - [Cleanup](#cleanup)
  - [Contributing](#contributing)
  - [License](#license)

## Prerequisites

To successfully run the tests, ensure you have the following tools installed:

- **Kubernetes** cluster
- **Helm** v3
- **kubectl**
- **istioctl**
- **curl**

### Kind

You can use [Kind](https://kind.sigs.k8s.io/) to set up a local test cluster for development and testing.

## Installation

### Setting Up the Cluster

1. **Install Kind**: If you haven't already, install Kind by following the [installation instructions](https://kind.sigs.k8s.io/docs/user/quick-start/#installation).
2. **Create a Kind Cluster**:

   ```bash
   kind create cluster --name istio-multi-control-planes
   ```

3. **Set your context to the Kind cluster**:

   ```bash
   kubectl cluster-info --context kind-istio-multi-control-planes
   ```

## Directory Structure

The repository is organized as follows:

- `setup/`: Contains installation scripts and Helm values for setting up Istio control planes.
- `test/`: Contains test scripts for validating connectivity and functionality across the control planes.
- `cleanup/`: Scripts to clean up resources after tests are executed.

## Usage

Follow these steps to set up the control planes, run tests, and clean up afterwards:

1. **Run Setup**:

   ```bash
   ./setup/install-controlplanes.sh
   ./setup/install-test-pods.sh
   ```

2. **Run Tests**:

   ```bash
   ./test/test-connectivity.sh
   ```

3. **Cleanup**:

   ```bash
   ./cleanup/cleanup.sh
   ```

## Tests

The test suite includes various connectivity tests to ensure that all deployed services cannot communicate across the different control planes. The primary script is `test/test-connectivity.sh`, which performs the following validations:

You can customize the tests or add new ones in the `test/` directory as needed.

## Cleanup

After running the tests, it’s essential to clean up resources to avoid incurring unnecessary costs or clutter in your cluster:

- **Cleanup Script**: The cleanup script will remove all installed components and restore the cluster to its initial state:

  ```bash
  ./cleanup/cleanup.sh
  ```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature/YourFeature`).
6. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
