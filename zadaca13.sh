#!/bin/bash
awk '{print $3, $2, $1}' "fruit_prices.txt"