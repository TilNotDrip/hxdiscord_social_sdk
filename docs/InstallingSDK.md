# Installing Discord Social SDK libraries.

This guide is for installing the Discord Social SDK libraries, as Discord Social SDK's guidelines do not allow you to distribute it.

Make sure that you read the [Discord Social SDK Terms](https://support-dev.discord.com/hc/articles/30225844245271)!


## Downloading the Discord Social SDK libraries

### Step 1: Create a Discord Developer Team
- Before you start, you'll need to create a developer team on the Discord Developer Portal. This team will be used to manage your Discord applications and SDK integrations.
- If you already have a team configured, you can skip this step.
	1. Create a developer team on the [Discord Developer Portal](https://discord.com/developers/teams).
- Later, you can invite your team members to your new team to collaborate on your integration.
### Step 2: Create a Discord Application
1. Create a new application on the Discord Developer Portal and assign it to your team.
2. Add a redirect URL in the `OAuth2` tab:
	- See [`discordpp::Client::Authorize`](https://discord.com/developers/docs/social-sdk/classdiscordpp_1_1Client.html#ace94a58e27545a933d79db32b387a468) for more details.
3. Enable the `Public Client` toggle in the `OAuth2` tab.
### Step 3: Enable Discord Social SDK for Your App
- Once you've created your Discord application, you'll need to enable the Discord Social SDK for it.
	1. Click on the `Getting Started` link under the Discord Social SDK section of the sidebar.
	2. Fill out the form to share details about your game.
	3. Click `Submit` and the Social SDK will be enabled for your application.
### Step 4: Download the Discord SDK for C++
1. Click on the `Downloads` link under the Discord Social SDK section of the sidebar.
2. Select the latest version from the version dropdown and download the SDK for C++.

## Installing the Discord Social SDK libraries

### Step 1: Getting the install path
- When compiling with the library for the first time, an error like this should show up:
	```
	Error: hxdiscord_social_sdk does not have the Discord Social SDK libraries.
	Please see https://github.com/TilNotDrip/hxdiscord_social_sdk/docs/InstallingSDK.md for installing said libraries.
	Install Path: [PATH]
	```
	- NOTICE: `[PATH]` is not the actual path.
- `[PATH]` is the install path that we need.
### Step 2: Extracting the libraries
1. Open the SDK archive file (`.zip`)
	- We recommend not using the built-in archive viewer in Windows, get [`7-Zip`](https://www.7-zip.org/) or [`WinRAR`](https://www.win-rar.com) instead.
2. Move everything in the `discord_social_sdk` folder to the install path we got from Step 1.
	- If there is no `discord_social_sdk` folder, no worries! Just move everything from that archive in that folder.
### Step 3: Compiling your application
You are all done! All you need to do now is to compile the application again so that `hxdiscord_social_sdk` can install the library.

## Updating Discord Social SDK libraries.
### Step 1: Update the Discord Social SDK
1. Remove the contents of `[PATH]` from earlier.
2. Do everything from `Downloading Discord Social SDK libraries` and `Installing Discord Social SDK libraries` again.
3. Compile your project with `-DDISCORD_SOCIAL_SDK_UPDATE`
	- This will force the library to re-install the SDK libraries.
