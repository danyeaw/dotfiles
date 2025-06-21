# dotfiles
My personal configuration files

This repository contains chezmoi templates for setting up YubiKey-based GPG signing and
SSH authentication with flexible email management for personal and work projects.

## Features

- **GPG commit signing** using YubiKey
- **SSH authentication** using YubiKey (via GPG agent)
- **Unified authentication** - one YubiKey PIN for both GPG and SSH
- **Environment variable setup** - works with fish shell (or any shell)
- **Flexible email management** - easy switching between personal and work emails
- **Automatic setup** on new machines

## Requirements

- YubiKey with GPG keys configured
- `gpg`, `ykman`, and `chezmoi` installed
- GPG keys with authentication capability [A]
- Fish shell (or adapt environment variable setup for your shell)

## Initial Setup

1. **Install chezmoi and initialize:**
   ```bash
   # Install chezmoi (varies by OS)
   chezmoi init https://github.com/danyeaw/dotfiles.git
   ```

2. **Apply configuration:**
   ```bash
   chezmoi apply
   ```
   You'll be prompted for:
   - Full name
   - Personal email address
   - Work email address
   - Default email (personal or work)

3. **Restart your shell** to pick up environment variables

4. **Add SSH public key to Git services:**
   ```bash
   cat ~/.ssh/id_rsa_yubikey.pub
   ```

## How It Works

The setup uses **environment variables** instead of SSH config templates:
- `SSH_AUTH_SOCK` points to GPG agent socket
- `GPG_TTY` set for proper terminal integration
- Works with any shell (fish config included)

## Email Management

The setup includes convenient Git aliases for switching between emails:

```bash
# Switch current repository to personal email
git personal

# Switch current repository to work email
git work

# Check current email
git whoami
```

### Example Usage

```bash
# Personal project
cd ~/projects/personal-project
git personal  # Sets email to personal
git commit -m "Personal commit"

# Work/open source project
cd ~/projects/company-oss-project
git work      # Sets email to work
git commit -m "Work commit"

# Check what email you're using
git whoami    # Shows current email
```

## Key Information

- **GPG Main Key:** 42239C515C9B9841
- **GPG Auth Subkey:** D0EEB58986755E7A (used for SSH)
- **SSH Method:** Environment variables (SSH_AUTH_SOCK)
- **Email switching:** Manual per-repository via Git aliases

## Testing

After setup, test with:
```bash
# Test GPG signing
echo "test" | gpg --clearsign

# Test SSH authentication
ssh -T git@github.com

# Test email switching
git whoami           # Shows current email
git personal && git whoami  # Switch and verify
git work && git whoami      # Switch and verify
```

## Troubleshooting

- **YubiKey not detected:** Replug YubiKey and restart GPG agent
- **SSH authentication fails:** Ensure SSH public key is added to Git services
- **Environment variables not set:** Restart shell after applying templates
- **Permission errors:** Check GPG directory permissions (700/600)

## Example Configuration

When you run `chezmoi apply`, you might be prompted like this:

```
Full name: Dan Yeaw
Personal email address: dan@yeaw.me
Work email address: dyeaw@anaconda.com  
Default email (personal/work): personal
```

This creates:
- **Default Git config**: Uses `dan@yeaw.me` as default
- **Email switching aliases**: `git personal`, `git work`, `git whoami`
- **Fish shell config**: Sets up YubiKey environment variables
- **GPG config**: Uses YubiKey for all commit signing
 