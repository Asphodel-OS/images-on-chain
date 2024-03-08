# images-on-chain

A library for storing, manipulating, and retrieving images files on the EVM, with a side of on chain metadata manipulation

Storing images on chain may not be the most efficient way to store data, but it is kind of cool. Particularly useful for dynamic NFT images without relying on off-chain infrastructure.

## Features

### Implemented

EVM

- Raw bytes storage, base64 encoding
- SVG wrapped images (for NFT marketplaces)
- Metadata encoding

NodeJS

- PNG to hexadecimal conversion

### Planned

- Raw pixel bitmap handling
- Image manipulation (particularly combining images)
- BMP support
