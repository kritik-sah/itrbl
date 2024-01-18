export function shortenEthAddress(
  ethAddress: string,
  startLength = 2,
  endLength = 2
) {
  if (ethAddress.length !== 42 || !ethAddress.startsWith("0x")) {
    // Check if the input is a valid Ethereum address
    console.error("Invalid Ethereum address");
    return ethAddress;
  }

  const prefix = ethAddress.slice(0, startLength + 2); // Include "0x"
  const suffix = ethAddress.slice(-endLength);

  return `${prefix}...${suffix}`;
}
