package discord_social_sdk.externs;

@:buildXml('<include name="${haxelib:hxdiscord_social_sdk}/externs/build.xml" />')
@:include('discordpp.h')
@:native("discordpp::Client")
extern class Client {
    public function new() {}
}