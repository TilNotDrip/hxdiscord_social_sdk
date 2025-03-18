package macro;

#if sys
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
import haxe.io.Path;

using StringTools;

class SocialSDKMacro
{
	public static var onWindows:Bool =  ~/^win/i.match(Sys.systemName());

	public static macro function initMacro():Void
	{
		var sdkPath:String = getSDKPath();
		var libraryPath:String = getLibraryPath();

		if(!FileSystem.exists(sdkPath))
		{
			FileSystem.createDirectory(sdkPath);

			print('Error: hxdiscord_social_sdk does not have the Discord Social SDK libraries.');
			print('Please see https://github.com/TilNotDrip/hxdiscord_social_sdk/docs/InstallingSDK.md for installing said libraries.');
			print('Install Path: $sdkPath');
			Sys.exit(3);
		}

		#if DISCORD_SOCIAL_SDK_UPDATE
		print('Preparing to delete old libraries...');

		function fullyDeleteDirectory(curDirectory:String)
		{
			for(file in FileSystem.readDirectory(curDirectory))
			{
				var filePath:String = curDirectory + file;
				if(FileSystem.isDirectory(filePath))
					fullyDeleteDirectory(filePath + '/');
				else
					FileSystem.deleteFile(filePath);
			}

			FileSystem.deleteDirectory(curDirectory);
		}

		fullyDeleteDirectory(libraryPath);

		print('Done!');

		if(true)
		#else
		if(!FileSystem.exists(libraryPath) || FileSystem.readDirectory(libraryPath).length < 1)
		#end
		{
			print('Preparing hxdiscord_social_sdk libraries...');

			try
			{
				FileSystem.createDirectory(libraryPath);
				
				var curFiles:Array<String> = [''];
				while(curFiles.length > 0)
				{
					var file:String = curFiles.shift();
					file = Path.normalize(file);
					
					var sdkFile:String = sdkPath + file;
					var libraryFile:String = libraryPath + file;

					if(FileSystem.isDirectory(sdkFile))
					{
						if (!sdkFile.endsWith("/"))
							sdkFile += '/';

						if (!libraryFile.endsWith("/"))
							libraryFile += '/';

						FileSystem.createDirectory(libraryFile);

						for(fileInDir in FileSystem.readDirectory(sdkFile))
						{
							var fileInDirPath:String = sdkFile.substring(sdkPath.length) + '/';
							curFiles.push(fileInDirPath + fileInDir);
						}
					}
					else
					{
						// im doing this instead of copy cuz im different B)
						var bytes:haxe.io.Bytes = File.getBytes(sdkFile);
						File.saveBytes(libraryFile, bytes);
					}
				}

				print('Done!');
			}
			catch(e)
			{
				print('Error: An error occured while copying libraries over!');
				print('More details: $e');
				Sys.exit(1);
			}
		}
	}

	public static function print(msg:String)
	{
		#if sys
		Sys.println(msg);
		#end
	}

	public static function getSDKPath():String
	{
		var toReturn:String;

		if(onWindows)
			toReturn = Sys.getEnv('USERPROFILE');
		else
			toReturn = Sys.getEnv('HOME');

		toReturn = Path.normalize(toReturn);

		if (!toReturn.endsWith("/"))
			toReturn += '/';

		toReturn += '.discord_social_sdk/';

		return toReturn;
	}

	public static function getLibraryPath():Null<String>
	{
		var haxelibProcess:Process = new Process('haxelib', ['config', 'hxdiscord_game_sdk']);

		if (haxelibProcess.exitCode() != 0)
			return null;
		
		var haxelibPath:String = haxelibProcess.stdout.readLine().trim();
		haxelibProcess.close();

		haxelibPath = Path.normalize(haxelibPath);

		if (!haxelibPath.endsWith("/"))
			haxelibPath += '/';

		haxelibPath += 'hxdiscord_social_sdk/';

		if(!FileSystem.exists(haxelibPath))
			return null;

		if(FileSystem.exists(haxelibPath + '.current'))
		{
			var versionFormatted:String = File.getContent(haxelibPath + '.current').split('.').join(',');

			return haxelibPath + versionFormatted + '/externs/sdk/';
		}
		else if(FileSystem.exists(haxelibPath + '.dev'))
		{
			var path:String = File.getContent(haxelibPath + '.dev');
			path = haxe.io.Path.normalize(path);

			if (!path.endsWith("/"))
				path += '/';

			return path + 'externs/sdk/';
		}
		else
			return null;
	}
}
#end