# Secret Management

This document explains how to work with secrets, certificates, and provisioning profiles in the SparX Wallet Flutter project.

## Overview

Application secret data is located in the project root in the `secrets` folder:

```
├── lib
├── ...
├── secrets/
│   ├── secrets.tar.gpg
│   ├── .secrets.example
│   └── .secrets
```

- `secrets.tar.gpg`: Encrypted archive containing all confidential data
- `.secrets.example`: Template for your own .secrets file
- `.secrets`: Your personal secrets file (not committed to the repository)

## Local Secrets Configuration

To set up your local secrets:

1. Copy the template: `cp secrets/.secrets.example secrets/.secrets`
2. Fill `.secrets` with your credentials:

```
export SECRET_PASSPHRASE="abc"
export MATCH_PASSWORD="qwerty"
export FASTLANE_USER="example@gmail.com"
export FASTLANE_PASSWORD="pass"
```

**Important notes:**

- Never commit your `.secrets` file to the repository
- `FASTLANE_USER` and `FASTLANE_PASSWORD` are your own Apple Developer credentials
- `SECRET_PASSPHRASE` and `MATCH_PASSWORD` should be obtained from your teammates
- `SECRET_PASSPHRASE` passphrase the GPG tarball (with secrets)
- `MATCH_PASSWORD`: passphrase for iOS provisioning profiles and certificates. Used for Fastlane's [match](https://docs.fastlane.tools/actions/match/) command.

## Working with the Encrypted Secrets Archive

### Decrypting Secrets

To decrypt the secrets archive:

```sh
melos decrypt-secrets
```

This command will place the secrets files in the necessary directories: `/secrets`, `/android`, and `/ios`.

When performing a build via Github Actions, secrets are temporarily located in the required folders. After building the application, `scripts/clean.sh` is run to remove secrets.

### Creating a New Secrets Archive

1. To create a new secrets archive, set up a directory structure:

```
somefolder/
├── android/
│   ├── your_keystore_name.keystore
│   ├── fastlane/
│   │   ├── GooglePlayServiceAccount.json
│   │   └── key.properties
├── fastlane/
│   ├── FirebaseADKey.json
│   └── FirebaseAPIKey.json
├── ios/
│   ├── fastlane/
│   │   └── YourDeveloperAppleAuthKey.p8
├── secrets/
│   ├── ios-provisioning-key
│   ├── ios-provisioning-key.pub
│   └── sentry-dsn.txt
```

- `/android/your_keystore_name.keystore` Keystore file in jks format. Used to sign an APK file

- `/android/fastlane/GooglePlayServiceAccount.json` File with Google service account credentials for interacting with the Google API and Google Play Developer API.

- `/android/key.properties` File with data for signing APK files.

- `/fastlane/FirebaseADKey.json` Needed to interact with the Firebase API. Contains data for scripts to interact with Firebase services.

- `/fastlane/FirebaseAPIKey.json` Used to update the build number in Firebase Realtime Database.

- `/ios/fastlane/YourDeveloperAppleAuthKey.p8` Required to work with the App Store Connect API.

- `/secrets/ios-provisioning-key` Provisioning Profile file

- `/secrets/ios-provisioning-key.pub` Apple public key to run match_assure.

- `/secrets/sentry-dsn.txt` Text file with dns for working with sentry.

2. Then create the encrypted archive:

```sh
tar -cf secrets.tar *
gpg --symmetric --cipher-algo AES256 secrets.tar
```

### Updating Secrets

To update existing secrets:

1. Decrypt the archive:

   ```sh
   gpg --output secrets.tar --decrypt secrets.tar.gpg
   ```

2. Unpack the archive:

   ```sh
   tar -xf secrets.tar
   ```

3. Update the necessary files and repackage:

   ```sh
   tar c * > secrets.tar
   gpg --symmetric --cipher-algo AES256 secrets.tar
   ```

4. Place the resulting file in the `secrets` directory

**Warning:** When archiving the contents, exclude unnecessary files like the old .gpg file and your personal .secrets file.

## iOS Certificates and Provisioning Profiles

For iOS we use [match](https://docs.fastlane.tools/actions/match/) to manage certificates and provisioning profiles. It's configured in `ios/fastlane/Matchfile`.  
There is no need to manually create certificates and profiles; match will do everything for you and save it.

To renew certificates and provisioning profiles after adding new devices to the Apple Developer Account, run the following command:

```sh
melos build:ios_match_new_devices
```

If you configuring a new machine, you should run the following command to install certificates and provisioning profiles:

```sh
melos build:ios_match_assure
```

The password for executing match commands is taken from the .secrets/MATCH_PASSWORD file.

Warning: If there are problems with the certificates or they are out of date, use a set of commands to create new certificates:

```sh
fastlane match nuke development
fastlane match nuke distribution
melos run build:ios_match_assure
```

This will not cause problems even if other application certificates are affected.

### Troubleshooting

#### Apple Verification Code Issues

When running the `melos run build:ios_match_assure` command through the terminal or another fastlane command that requires entering a 6-digit apple verification code, the code may be ignored by the terminal. Instead of entering code, a line break occurs.

To work around this issue, in the project root or another location, create a text file fastlane_session.txt (the name can be anything).

1. Create a fastlane session token:

   ```sh
   touch fastlane_session.txt
   fastlane spaceauth -u YOUR_APPLE_ID
   ```

2. Copy the token to fastlane_session.txt and set an environment variable:

> Remove extra characters such as `\n`

   ```sh
   export FASTLANE_SESSION=$(cat fastlane_session.txt)
   ```

Example contents of the fastlane_session.txt file:

```yaml
---
- !ruby/object:HTTP::Cookie
  name: abcdefg
  value: ABCDEFG111111cf12345a12
  for_domain: true
  path: "/"
  secure: true
  httponly: true
  expires:
  max_age:
  created_at: 2024-06-07 23:51:26.367930000 +07:00
  accessed_at: 2024-06-07 23:51:26.372267000 +07:00
- !ruby/object:HTTP::Cookie
  name: ABCDE
  ...
```

#### Repository Cloning Issues

If cloning the repository takes a long time when running the command `melos build:ios_match_new_devices`, then possible reasons:

1. Insufficient rights. Contact the administrator.
2. You need an ssh key.

Variant of fix:

1. Ensure you have proper permissions
2. Set up an SSH key:
   - Create and add an SSH key to GitHub
   - Run `cd ~/.ssh/; ssh-add` in your terminal

## GitHub Actions Secrets

For CI/CD, the following secrets are needed in GitHub repository settings:

- `BOT_ACCESS_TOKEN`: Personal access token (PAT) used to fetch the repository. We should use PAT and not default GITHUB_TOKEN because ["When you use the repository's GITHUB_TOKEN to perform tasks, events triggered by the GITHUB_TOKEN, with the exception of workflow_dispatch and repository_dispatch, will not create a new workflow run"](https://docs.github.com/en/actions/using-workflows/triggering-a-workflow#triggering-a-workflow-from-a-workflow). We want to trigger a workflow from the workflow (to run tests), so we need to use PAT. This thing is used in `version` workflow.
- `SECRET_PASSPHRASE`: Same as in your local `.secrets` file
- `MATCH_PASSWORD`: Same as in your local `.secrets` file

**Warning: `SECRET_PASSPHRASE` needs to be located in CI/CD (when using Github Actions, located in the Secrets of the repository) to decrypt the gpg file.**

