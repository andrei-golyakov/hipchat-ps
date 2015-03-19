#hipchat-ps
The hipchat-ps module to send a HipChat room notifications using Windows PowerShell.
This module is working with HipChat API v2 https://www.hipchat.com/docs/apiv2.

## Getting Started
#1. Copy this module to any location found in $env:PSModulePath
#1. Import the module

	C:\PS>Import-Module Publish-HipChatRoomMessage

#1. List available functions

		C:\PS>Get-Command -Module Publish-HipChatRoomNotification

#1. Get help on the module

		C:\PS>Get-Help Publish-HipChatRoomNotification -examples

		C:\PS>Get-Help Publish-HipChatRoomNotification -detailed

#1. Execute the module

		C:\PS>Publish-HipChatRoomNotification -authToken "AUTH_TOKEN" -roomIdOrName "ROOM_ID_OR_NAME" -message "<div><a href=""#"">HTML link</a> example.</div>"

## Disclaimer
NO warranty, expressed or written.