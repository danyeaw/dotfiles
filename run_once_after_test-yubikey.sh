#!/bin/bash
set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "🧪 YubiKey Quick Test"
echo "===================="

# Test 1: YubiKey Detection
echo -n "YubiKey detected: "
if gpg --card-status >/dev/null 2>&1; then
    echo -e "${GREEN}✅ YES${NC}"
    YUBIKEY_OK=1
else
    echo -e "${RED}❌ NO${NC}"
    YUBIKEY_OK=0
fi

# Test 2: SSH Keys Available  
echo -n "SSH keys available: "
if ssh-add -L >/dev/null 2>&1; then
    echo -e "${GREEN}✅ YES${NC}"
    SSH_OK=1
else
    echo -e "${RED}❌ NO${NC}"
    SSH_OK=0
fi

# Test 3: GPG Signing Works
echo -n "GPG signing works: "
if gpg --list-secret-keys >/dev/null 2>&1; then
    echo -e "${GREEN}✅ YES${NC}"
    GPG_OK=1
else
    echo -e "${RED}❌ NO${NC}"
    GPG_OK=0
fi

echo ""

# Results
TOTAL=$((YUBIKEY_OK + SSH_OK + GPG_OK))
if [[ $TOTAL -eq 3 ]]; then
    echo -e "${GREEN}🎉 All tests passed! YubiKey is working.${NC}"
    exit 0
elif [[ $YUBIKEY_OK -eq 0 ]]; then
    echo -e "${RED}❌ YubiKey not detected. Check connection and try: gpg --card-status${NC}"
    exit 1
else
    echo -e "${RED}⚠️ YubiKey detected but ${NC}$((3-TOTAL))${RED} issue(s) found.${NC}"
    echo ""
    echo "Quick fixes:"
    [[ $SSH_OK -eq 0 ]] && echo "  SSH: gpgconf --kill gpg-agent && gpg-agent --daemon --enable-ssh-support"
    [[ $GPG_OK -eq 0 ]] && echo "  GPG: gpg --card-edit (then 'fetch' and 'quit')"
    exit 1
fi

