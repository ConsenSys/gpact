#!/usr/bin/env bash
set -e
rm -rf build

HERE=contracts/solidity/lockablestorage
BUILDDIR=$HERE/build
CONTRACTSDIR=$HERE/src/main/solidity
TESTCONTRACTSDIR=$HERE/src/test/solidity
OUTPUTDIR=$HERE/src/main/java
TESTOUTPUTDIR=$HERE/src/test/java
PACKAGE=net.consensys.gpact.lockablestorage.soliditywrappers
#WEB3J=web3j
WEB3J=../web3j-rlp/codegen/build/install/codegen/bin/codegen


# compiling one file also compiles its dependencies. We use overwrite to avoid the related warnings.
solc $TESTCONTRACTSDIR/MockCbcForLockableStorageTest.sol --allow-paths . --bin --abi --optimize -o $BUILDDIR --overwrite
solc $TESTCONTRACTSDIR/TestLockableStorageWrapper.sol --allow-paths . --bin --abi --optimize -o $BUILDDIR --overwrite
# ls -al $BUILDDIR

$WEB3J solidity generate -a=$BUILDDIR/MockCbcForLockableStorageTest.abi -b=$BUILDDIR/MockCbcForLockableStorageTest.bin -o=$TESTOUTPUTDIR -p=$PACKAGE
$WEB3J solidity generate -a=$BUILDDIR/TestLockableStorageWrapper.abi -b=$BUILDDIR/TestLockableStorageWrapper.bin -o=$TESTOUTPUTDIR -p=$PACKAGE
