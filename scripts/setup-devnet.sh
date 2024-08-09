#!/usr/bin/env bash

# Usage: ./setup-devnet.sh <PROGRAM_ID> <NEW_PROFILE_NAME> [additional arguments]

# Check if required arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <PROGRAM_ID> <NEW_PROFILE_NAME> [additional arguments]"
    exit 1
fi

PROGRAM_ID=$1
NEW_PROFILE_NAME=$2
shift 2  # Remove the first two arguments

RPC_ENDPOINT=https://api.devnet.solana.com
KEYPAIR_PATH=/home/icefrog/.config/solana/id.json
# KEYPAIR_PATH=./../client.json

# Create a new profile
mfi profile create \
    --cluster devnet \
    --name "$NEW_PROFILE_NAME" \
    --keypair-path "$KEYPAIR_PATH" \
    --rpc-url "$RPC_ENDPOINT" \
    --program-id "$PROGRAM_ID"

# Set the newly created profile
mfi profile set "$NEW_PROFILE_NAME"

# Create a new group with any additional arguments
mfi group create "$@" -y

# Add USDC bank
mfi group add-bank \
    --mint GAKS74QSGdt4tN4SLH6bHhJfAucYu3e8Dwf6hRRcJaU1 \
    --asset-weight-init 0.85 \
    --asset-weight-maint 0.9 \
    --liability-weight-maint 1.1 \
    --liability-weight-init 1.15 \
    --deposit-limit-ui 1000000000000000\
    --borrow-limit-ui 1000000000000000\
    --pyth-oracle ef0d8b6fda2ceba41da15d4095d1da392a0d2f8ed0c6c7bc0f4cfac8c280b56d \
    --optimal-utilization-rate 0.9 \
    --plateau-interest-rate 1 \
    --max-interest-rate 10 \
    --insurance-fee-fixed-apr 0.01 \
    --insurance-ir-fee 0.1 \
    --protocol-fixed-fee-apr 0.01 \
    --protocol-ir-fee 0.1 \
    --oracle-type pyth-push-oracle \
    --risk-tier collateral \
    -y \
    "$@"

# # Add SOL bank
# mfi group add-bank \
#     --mint 4Bn9Wn1sgaD5KfMRZjxwKFcrUy6NKdyqLPtzddazYc4x \
#     --asset-weight-init 0.75 \
#     --asset-weight-maint 0.8 \
#     --liability-weight-maint 1.2 \
#     --liability-weight-init 1.25 \
#     --deposit-limit 1000000000000000\
#     --borrow-limit 1000000000000000\
#     --pyth-oracle J83w4HKfqxwcq3BEMMkPFSppX3gqekLyLJBexebFVkix \
#     --optimal-utilization-rate 0.8 \
#     --plateau-interest-rate 1 \
#     --max-interest-rate 20 \
#     --insurance-fee-fixed-apr 0.01 \
#     --insurance-ir-fee 0.1 \
#     --protocol-fixed-fee-apr 0.01 \
#     --protocol-ir-fee 0.1 \
#     -y \
#     "$@"
