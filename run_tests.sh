#!/bin/sh

echo "Starting tests..."

# Test php is installed
if ! command -v php &>/dev/null; then
  echo "php could not be found"
  exit 1
fi

$PHP_VERSION=$(php -v)
echo "PHP instalado: " $PHP_VERSION
