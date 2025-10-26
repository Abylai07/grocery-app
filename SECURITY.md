# Security Policy

## Overview

This document outlines the security practices and guidelines for the Abricoz App project. Following these guidelines helps protect sensitive data and maintain the security of the application.

## 🔐 Sensitive Data Management

### Never Commit These Files

The following files contain sensitive information and should **NEVER** be committed to version control:

1. **Environment Configuration**
   - `lib/src/common/env_config.dart` - Contains API keys and secrets
   - Always use `env_config.example.dart` as a template

2. **Firebase Configuration Files**
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`
   - These files contain your Firebase project credentials

3. **Build Artifacts**
   - `android/.gradle/`
   - `android/.kotlin/`
   - `android/app/.cxx/`
   - `build/` directories

4. **Local Configuration**
   - `.env` files
   - `android/key.properties`
   - `android/local.properties`

### What's Safe to Commit

The following files are generally safe to commit:

1. **Firebase Options**
   - `lib/firebase_options.dart` - Contains client-side Firebase config
   - These are public client keys designed to be included in apps
   - **However**: Ensure your Firebase Security Rules are properly configured

2. **Example/Template Files**
   - `env_config.example.dart`
   - Any `.example` files

## 🛡️ API Keys and Secrets

### Current API Keys Used

1. **Google Maps API Key**
   - Used for: Geocoding and address autocomplete
   - Location: `lib/src/common/env_config.dart`
   - Security: Restricted by API key restrictions in Google Cloud Console

2. **Firebase API Keys**
   - Used for: Authentication, Analytics, Messaging, Crashlytics
   - Location: `firebase_options.dart`
   - Security: Protected by Firebase Security Rules

3. **Development Keys**
   - Used for: Internal development and testing
   - Location: `lib/src/common/env_config.dart`
   - Security: Should be rotated regularly

### API Key Security Best Practices

1. **Google Maps API Key**:
   - Set application restrictions (Android/iOS package names)
   - Set API restrictions (only enable needed APIs)
   - Monitor usage in Google Cloud Console
   - Set quota limits to prevent abuse

2. **Firebase**:
   - Configure Firebase Security Rules for Firestore/Realtime Database
   - Enable App Check for additional security
   - Monitor Firebase usage and alerts
   - Use Firebase Authentication for user management

3. **General Guidelines**:
   - Rotate keys if they are exposed
   - Use different keys for development and production
   - Monitor API usage for anomalies
   - Never log API keys or secrets

## 🔒 Environment Configuration

### Setup Process

1. **Initial Setup**:
   ```bash
   # Copy the example file
   cp lib/src/common/env_config.example.dart lib/src/common/env_config.dart
   ```

2. **Add Your Keys**:
   Edit `env_config.dart` and replace placeholder values with actual keys.

3. **Verify .gitignore**:
   Ensure `env_config.dart` is listed in `.gitignore`:
   ```
   lib/src/common/env_config.dart
   ```

4. **Check Status**:
   ```bash
   # This should NOT list env_config.dart
   git status
   ```

### Sharing Keys with Team

**DO NOT** commit keys to git. Instead:

1. **Use Secure Channels**:
   - Share via encrypted messaging
   - Use password managers with sharing features
   - Use team secret management tools (1Password, Vault, etc.)

2. **For CI/CD**:
   - Use environment variables
   - Use GitHub Secrets (for GitHub Actions)
   - Use secure CI/CD environment variable storage

## 🚨 What to Do if Keys Are Exposed

If API keys or secrets are accidentally committed:

1. **Immediately**:
   - Rotate/regenerate the exposed keys
   - Check API usage for unauthorized access
   - Review git history to remove sensitive data

2. **Remove from Git History**:
   ```bash
   # Use git filter-branch or BFG Repo-Cleaner
   # WARNING: This rewrites history
   git filter-branch --force --index-filter \
     "git rm --cached --ignore-unmatch lib/src/common/env_config.dart" \
     --prune-empty --tag-name-filter cat -- --all

   # Force push (coordinate with team first!)
   git push --force --all
   ```

3. **Better Alternative - Use BFG**:
   ```bash
   # Install BFG Repo-Cleaner
   # Then run:
   bfg --delete-files env_config.dart
   git reflog expire --expire=now --all
   git gc --prune=now --aggressive
   ```

4. **Notify Team**:
   - Inform all team members
   - Update keys across all environments
   - Monitor for suspicious activity

## 🔍 Security Checklist Before Publishing

Before pushing to GitHub or releasing, verify:

- [ ] `env_config.dart` is not in git
- [ ] `google-services.json` is not in git
- [ ] `GoogleService-Info.plist` is not in git
- [ ] No hardcoded API keys in source code
- [ ] `.gitignore` is properly configured
- [ ] `git status` shows no sensitive files
- [ ] All debug print statements are wrapped in `kDebugMode`
- [ ] Firebase Security Rules are configured
- [ ] API keys have proper restrictions set
- [ ] Tested that app works without sensitive data in git

## 📋 Code Review Guidelines

When reviewing code, check for:

1. **Hardcoded Secrets**:
   - API keys in code
   - Passwords or tokens
   - URLs with embedded credentials

2. **Logging Sensitive Data**:
   - Don't log user data
   - Don't log authentication tokens
   - Wrap debug logs in `kDebugMode`

3. **Proper Error Handling**:
   - Don't expose internal errors to users
   - Use appropriate error messages
   - Log errors securely for debugging

## 🛠️ Firebase Security

### Firestore Security Rules

Ensure your Firestore rules are properly configured:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Example: Authenticated users only
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### Firebase Authentication

- Use Firebase Authentication for user management
- Enable only necessary sign-in methods
- Configure authorized domains
- Set up email enumeration protection

### App Check

Consider enabling Firebase App Check:
- Protects backend resources from abuse
- Verifies requests come from your authentic app
- Helps prevent unauthorized API usage

## 📞 Reporting Security Issues

If you discover a security vulnerability:

1. **Do NOT** create a public GitHub issue
2. Contact the development team privately
3. Provide detailed information about the vulnerability
4. Allow time for the issue to be addressed before disclosure

## 📚 Additional Resources

- [OWASP Mobile Security](https://owasp.org/www-project-mobile-security/)
- [Flutter Security Best Practices](https://docs.flutter.dev/security)
- [Firebase Security Documentation](https://firebase.google.com/docs/rules)
- [Google Cloud API Security](https://cloud.google.com/docs/authentication)

---

**Last Updated**: 2025

Remember: Security is everyone's responsibility. When in doubt, ask the team!
