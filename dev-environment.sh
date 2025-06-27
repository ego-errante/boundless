#!/usr/bin/env bash
# boundless_dev.sh – set up a Boundless dev environment and run the sample app
# Works on macOS or Linux.  Run:  chmod +x boundless_dev.sh && ./boundless_dev.sh
set -euo pipefail

###############################################################################
# Part 0 – Prerequisites (manual)
###############################################################################
# TODO: Install Rust (https://www.rust-lang.org/tools/install) and Git if absent
# TODO: Ensure Homebrew/apt/yum is installed for any missing build deps
###############################################################################

###############################################################################
# Part 1 – Get the tools
###############################################################################

echo "📦  Installing RISC Zero toolchain …"
curl -L https://risczero.com/install | bash                # download rzup
# shellcheck disable=SC1091
source "${HOME}/.bashrc" 2>/dev/null || true                # reload PATH
rzup install                                                # install components

echo "📦  Installing Foundry …"
curl -L https://foundry.paradigm.xyz | bash                 # download foundryup
# shellcheck disable=SC1091
source "${HOME}/.bashrc" 2>/dev/null || true                # reload PATH
foundryup                                                   # install forge/cast/anvil/chisel

echo "📂  Cloning Boundless template …"
git clone https://github.com/boundless-xyz/boundless-foundry-template
cd boundless-foundry-template
git submodule update --init --recursive                     # pull submodules

###############################################################################
# Part 1.5 – Environment variables
###############################################################################
cat <<'EOF' > .env
# .env – DO NOT COMMIT!
PRIVATE_KEY=        # ← your testnet private key
PINATA_JWT=         # ← optional: Pinata JWT for custom guest uploads
EOF
echo "⚠️   Edit boundless-foundry-template/.env and add your keys before continuing."
# The template also ships with `.env.testnet` – leave it as-is.

###############################################################################
# Part 1.6 – Build & test
###############################################################################
echo "🛠   Building guest + host code …"
cargo build
echo "🧪  Running Rust tests …"
cargo test
echo "🧪  Running Solidity tests …"
forge test -vvv

###############################################################################
# Part 2 – Lock-in-stake fix (manual code change)
###############################################################################
# TODO: In apps/src/main.rs, import Unit and set a 1 USDC lock-in stake:
#   use alloy::primitives::{utils::Unit, Address, U256};
#   …
#   .config_offer_layer(|config| config.lock_stake(U256::from(1) * Unit::MWEI.wei_const()))

###############################################################################
# Part 3 – Run the example application
###############################################################################
echo "🚀  Running example app …"
set -a
# shellcheck disable=SC1091
source .env
# shellcheck disable=SC1091
source .env.testnet
set +a

RUST_LOG=info cargo run --bin app -- \
  --rpc-url "${RPC_URL:?}" \
  --private-key "${PRIVATE_KEY:?}" \
  --even-number-address "${EVEN_NUMBER_ADDRESS:?}" \
  --number 4 \
  --program-url "https://plum-accurate-weasel-904.mypinata.cloud/ipfs/QmU7eqsYWguHCYGQzcg42faQQkgRfWScig7BcsdM1sJciw"

echo "✅  Boundless quick-start complete!"
