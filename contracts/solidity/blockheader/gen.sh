#!/usr/bin/env bash
set -e
rm -rf build

HERE=contracts/solidity/blockheader
BUILDDIR=$HERE/build
CONTRACTSDIR=$HERE/src/main/solidity
TESTCONTRACTSDIR=$HERE/src/test/solidity
OUTPUTDIR=$HERE/src/main/java
TESTOUTPUTDIR=$HERE/src/test/java
PACKAGE=net.consensys.gpact.soliditywrappers
TESTPACKAGE=net.consensys.gpact.test.blockheader.soliditywrappers
# WEB3J=web3j
WEB3J=../web3j-rlp/codegen/build/install/codegen/bin/codegen

# compiling one file also compiles its dependendencies. We use overwrite to avoid the related warnings.
solc $CONTRACTSDIR/TxReceiptsRootStorage.sol --allow-paths . --bin --abi --optimize -o $BUILDDIR --overwrite
solc $TESTCONTRACTSDIR/TestEvents.sol --allow-paths . --bin --abi --optimize -o $BUILDDIR --overwrite
# ls -al $BUILDDIR
$WEB3J solidity generate -a=$BUILDDIR/TxReceiptsRootStorage.abi -b=$BUILDDIR/TxReceiptsRootStorage.bin -o=$OUTPUTDIR -p=$PACKAGE
$WEB3J solidity generate -a=$BUILDDIR/TestEvents.abi -b=$BUILDDIR/TestEvents.bin -o=$TESTOUTPUTDIR -p=$TESTPACKAGE


