#!/bin/bash
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install GPG on macOS
install_gpg_macos() {
    print_status "GPG tools not found. Installing via Homebrew..."
    
    if ! command_exists brew; then
        print_error "Homebrew not found. Please install GPG manually:"
        echo "  Option 1: Install Homebrew first: https://brew.sh"
        echo "  Option 2: Download GPG Suite: https://gpgtools.org"
        echo "  Option 3: Install via MacPorts: sudo port install gnupg2"
        exit 1
    fi
    
    print_status "Installing GnuPG via Homebrew..."
    brew install gnupg
    
    # Also install pinentry for macOS if not present
    if ! command_exists pinentry-mac; then
        print_status "Installing pinentry-mac for secure PIN entry..."
        brew install pinentry-mac
    fi
    
    print_success "GPG tools installed successfully"
}

echo "Setting up YubiKey SSH authentication..."
echo "Personal email: {{ .personal_email }}"
echo "Work email: {{ .work_email }}"
echo "Default email: {{ .default_email }}"
echo

# Check for required dependencies
if [[ "$OSTYPE" == "darwin"* ]]; then
    print_status "Detected macOS system"
    
    # Check for GPG tools
    if ! command_exists gpg || ! command_exists gpgconf || ! command_exists gpg-agent; then
        install_gpg_macos
    else
        print_success "GPG tools found"
    fi
    
    # Ensure proper pinentry is configured for macOS
    if [ ! -f ~/.gnupg/gpg-agent.conf ] || ! grep -q "pinentry-mac" ~/.gnupg/gpg-agent.conf 2>/dev/null; then
        print_status "Configuring pinentry for macOS..."
        mkdir -p ~/.gnupg
        if command_exists pinentry-mac; then
            echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
        fi
    fi
    
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    print_status "Detected Linux system"
    
    if ! command_exists gpg || ! command_exists gpgconf; then
        print_error "GPG tools not found. Install with:"
        echo "  Ubuntu/Debian: sudo apt install gnupg"
        echo "  Fedora: sudo dnf install gnupg2"
        echo "  Arch: sudo pacman -S gnupg"
        exit 1
    fi
else
    print_warning "Unknown operating system: $OSTYPE"
    print_status "Proceeding with GPG setup..."
fi

# Create and fix GPG directory permissions
mkdir -p ~/.gnupg
chmod 700 ~/.gnupg

# Fix permissions on existing files (suppress errors for empty directory)
if [ -n "$(ls -A ~/.gnupg 2>/dev/null)" ]; then
    chmod 600 ~/.gnupg/* 2>/dev/null || true
fi

print_success "GPG directory permissions configured"

# Ensure SSH directory exists with proper permissions
mkdir -p ~/.ssh
chmod 700 ~/.ssh
print_success "SSH directory configured"

# Kill any existing GPG agent to pick up new config
print_status "Restarting GPG agent..."
gpgconf --kill gpg-agent 2>/dev/null || true
gpgconf --kill scdaemon 2>/dev/null || true
sleep 2

# Start GPG agent (will read config and create SSH socket)
print_status "Starting GPG agent..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # On macOS, we might need to start the agent differently
    gpg-agent --daemon --enable-ssh-support 2>/dev/null || true
else
    gpg-agent --daemon 2>/dev/null || true
fi

# Wait a moment for the agent to start
sleep 1

# Extract SSH public key from GPG authentication subkey
print_status "Extracting SSH public key from GPG authentication subkey..."

# First, let's check if we can see the YubiKey
if ! gpg --card-status >/dev/null 2>&1; then
    print_warning "YubiKey not detected. Please ensure:"
    echo "  1. YubiKey is properly inserted"
    echo "  2. YubiKey has GPG keys configured"
    echo "  3. You have the necessary permissions"
    echo ""
    print_status "Attempting to continue with key extraction..."
fi

# Try to extract the SSH key
SSH_KEY_EXTRACTED=false

# Try authentication subkey first
if [ -n "{{ .gpg_auth_subkey }}" ] && gpg --export-ssh-key "{{ .gpg_auth_subkey }}" > ~/.ssh/id_rsa_yubikey.pub 2>/dev/null; then
    print_success "SSH public key extracted from authentication subkey"
    SSH_KEY_EXTRACTED=true
# Fallback to main key
elif [ -n "{{ .gpg_main_key }}" ] && gpg --export-ssh-key "{{ .gpg_main_key }}" > ~/.ssh/id_rsa_yubikey.pub 2>/dev/null; then
    print_success "SSH public key extracted from main key"
    SSH_KEY_EXTRACTED=true
else
    print_error "Failed to extract SSH public key"
    echo "Troubleshooting steps:"
    echo "  1. Ensure YubiKey is properly inserted"
    echo "  2. Check that GPG keys are properly configured on the YubiKey"
    echo "  3. Try: gpg --card-status"
    echo "  4. Try: gpg --list-secret-keys"
    echo "  5. You may need to replug your YubiKey and try again"
    
    # Don't exit here, let the user see the setup information
    print_warning "Continuing with setup instructions..."
fi

if [ "$SSH_KEY_EXTRACTED" = true ]; then
    chmod 644 ~/.ssh/id_rsa_yubikey.pub
    echo ""
    print_success "SSH Public Key:"
    cat ~/.ssh/id_rsa_yubikey.pub
fi

echo ""
echo "=== Setup Complete ==="
echo "Your YubiKey is configured for:"
echo "- GPG commit signing (key: {{ .gpg_main_key }})"
echo "- SSH authentication (subkey: {{ .gpg_auth_subkey }})"
echo "- Default email: {{ .default_email }}"
echo ""

if [ "$SSH_KEY_EXTRACTED" = true ]; then
    echo "✅ Add this SSH public key to your Git services:"
    echo "cat ~/.ssh/id_rsa_yubikey.pub"
else
    echo "⚠️  SSH key extraction failed. After fixing the issue, run:"
    echo "gpg --export-ssh-key {{ .gpg_auth_subkey }} > ~/.ssh/id_rsa_yubikey.pub"
fi

echo ""
echo "📧 Email switching commands:"
echo "- Use 'git personal' to switch current repo to {{ .personal_email }}"
echo "- Use 'git work' to switch current repo to {{ .work_email }}"
echo "- Use 'git whoami' to see current email"

echo ""
print_status "macOS-specific notes:"
echo "- GPG agent will start automatically on login"
echo "- If you experience issues, try: gpgconf --kill gpg-agent && gpg-agent --daemon"
echo "- For SSH authentication, ensure your shell loads GPG agent's SSH socket"

echo ""
print_status "To test SSH authentication with your YubiKey:"
echo "1. Try: ssh-add -L  # Should show your YubiKey's SSH key"
echo "2. Test SSH connection to your Git service"

# YubiKey Test Function
run_yubikey_tests() {
    local tests_passed=0
    local tests_failed=0
    local tests_warned=0

    # Test function helpers
    test_pass() {
        ((tests_passed++))
        print_success "$1"
    }

    test_fail() {
        ((tests_failed++))
        print_error "$1"
    }

    test_warn() {
        ((tests_warned++))
        print_warning "$1"
    }

    echo ""

    # Test 1: YubiKey detection
    print_status "Testing YubiKey detection..."
    if gpg --card-status >/dev/null 2>&1; then
        local serial=$(gpg --card-status 2>/dev/null | grep "Serial number" | awk '{print $4}')
        test_pass "YubiKey detected (Serial: $serial)"
    else
        test_fail "YubiKey not detected"
    fi

    # Test 2: SSH Auth Sock Configuration
    print_status "Testing SSH_AUTH_SOCK configuration..."
    local current_sock="${SSH_AUTH_SOCK:-}"
    local expected_sock=$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null || echo "")
    
    if [ -n "$current_sock" ] && [ "$current_sock" = "$expected_sock" ]; then
        test_pass "SSH_AUTH_SOCK correctly configured"
    else
        test_fail "SSH_AUTH_SOCK misconfigured"
        echo "    Current:  $current_sock"
        echo "    Expected: $expected_sock"
        echo "    Fix: Restart Fish shell or run 'gpgconf --kill gpg-agent && gpg-agent --daemon --enable-ssh-support'"
    fi

    # Test 3: SSH keys available
    print_status "Testing SSH key availability..."
    local ssh_output=$(ssh-add -L 2>&1)
    if [ $? -eq 0 ] && [ -n "$ssh_output" ]; then
        local key_count=$(echo "$ssh_output" | wc -l | tr -d ' ')
        test_pass "SSH keys available ($key_count key(s))"
        echo "    Preview: $(echo "$ssh_output" | head -1 | cut -c1-50)..."
    else
        test_fail "No SSH keys available from GPG agent"
        echo "    Error: $ssh_output"
        echo "    Try: gpgconf --kill gpg-agent && gpg-agent --daemon --enable-ssh-support"
    fi

    # Test 4: SSH public key file
    print_status "Testing SSH public key file..."
    if [ -f ~/.ssh/id_rsa_yubikey.pub ]; then
        test_pass "SSH public key file exists"
        local key_type=$(head -1 ~/.ssh/id_rsa_yubikey.pub | awk '{print $1}')
        echo "    Key type: $key_type"
    else
        test_fail "SSH public key file not found"
    fi

    # Test 5: GPG signing capability (non-interactive)
    print_status "Testing GPG signing capability..."
    if gpg --list-secret-keys --with-colons | grep -q "^sec"; then
        test_pass "GPG secret key available"
        # Try a non-interactive signing test
        if echo "test" | gpg --batch --yes --pinentry-mode loopback --passphrase "" --clearsign >/dev/null 2>&1; then
            test_pass "GPG signing works (no PIN required)"
        else
            test_warn "GPG signing requires PIN entry (this is normal and secure)"
            echo "    Your YubiKey is properly configured but requires PIN for signing"
        fi
    else
        test_fail "No GPG secret keys found"
    fi

    # Test 6: Git configuration
    print_status "Testing Git configuration..."
    local git_key=$(git config --global user.signingkey 2>/dev/null || echo "")
    local git_sign=$(git config --global commit.gpgsign 2>/dev/null || echo "")
    
    if [ -n "$git_key" ]; then
        test_pass "Git signing key configured: $git_key"
    else
        test_warn "Git signing key not configured"
        echo "    Fix: git config --global user.signingkey {{ .gpg_main_key }}"
    fi
    
    if [ "$git_sign" = "true" ]; then
        test_pass "Git auto-signing enabled"
    else
        test_warn "Git auto-signing not enabled"
        echo "    Fix: git config --global commit.gpgsign true"
    fi

    echo ""
    echo "🏆 Test Results: ✅ $tests_passed passed, ⚠️ $tests_warned warnings, ❌ $tests_failed failed"
    
    if [ $tests_failed -eq 0 ]; then
        echo -e "${GREEN}🎉 YubiKey setup verification complete!${NC}"
    else
        echo -e "${YELLOW}⚠️ Some tests failed. Quick fixes:${NC}"
        echo ""
        echo "🔧 Most common fixes:"
        echo "  1. Restart Fish shell: exec fish"
        echo "  2. Restart GPG agent: gpgconf --kill gpg-agent && gpg-agent --daemon --enable-ssh-support"
        echo "  3. Check YubiKey is inserted and try: gpg --card-status"
        echo "  4. Test SSH manually: ssh-add -L"
        echo ""
    fi
}

print_success "YubiKey setup complete!"

echo ""
echo "🧪 Running YubiKey tests to verify setup..."
echo "============================================"

run_yubikey_tests

