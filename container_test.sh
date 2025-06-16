#!/usr/bin/env bash
echo "🧪 Testing semantic-release container image"
semantic-release --version

echo "🧪 Testing CA"
curl -s https://vault.rachuna-net.pl/
