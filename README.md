# hipchat-ps

This module is written to send a HipChat room notifications using Windows PowerShell.  
Based on [HipChat API v2](https://www.hipchat.com/docs/apiv2).

##Getting Started

#### Copy this module to any location found in
	$env:PSModulePath

#### Import the module
	C:\PS>Import-Module Publish-HipChatRoomMessage

#### List available functions
	C:\PS>Get-Command -Module Publish-HipChatRoomNotification

#### Get help on the module
	C:\PS>Get-Help Publish-HipChatRoomNotification -examples
	C:\PS>Get-Help Publish-HipChatRoomNotification -detailed

#### Execute the module
	C:\PS>Publish-HipChatRoomNotification -authToken "AUTH_TOKEN" -roomIdOrName "ROOM_ID_OR_NAME" -message "<a href=""#"">HTML link</a>.</div>"

## Disclaimer
NO warranty, expressed or written.