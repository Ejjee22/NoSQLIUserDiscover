# UserDiscover.sh

## Description

`UserDiscover.sh` is a Bash script designed to perform username fuzzing on an authentication server. It uses a recursive technique to generate possible usernames and sends HTTP POST requests to verify their validity. The script leverages a NoSQL injection to use regular expressions (regex) for the username matching. This script is specifically intended to solve the laboratory in Docker from the [vulnerable-node-app](https://github.com/Charlie-belmer/vulnerable-node-app) repository by Charlie Belmer.

## Usage

The script runs directly from the command line. Ensure you have the necessary permissions and that the authentication server is running. By default, the script targets `http://localhost:4000/user/login`, but you can modify the `url` variable within the script to specify a different authentication service URL.

### Requirements

- `bash` (Bourne Again SHell)
- `curl` (Command line tool for transferring data with URL syntax)
- An authentication server that accepts POST requests with JSON data.
