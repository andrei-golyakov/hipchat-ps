function Publish-HipChatRoomNotification{
<#

.SYNOPSIS
	A powershell script for sending a notification to a room in HipChat
.DESCRIPTION
	A powershell script for sending a notification to a room in HipChat
.LINK
	https://github.com/lholman/hipchat-ps
.NOTES
	Author: Anderi 
	DateCreated: 03/18/2015
	Requirements: Copy this module to any location found in $env:PSModulePath
.PARAMETER authToken
	Required. Your HipChat API token, that you can create here https://www.hipchat.com/account/api
.PARAMETER roomIdOrName
	Required. The id or name of the room. Valid length range: 1 - 100.
.PARAMETER message
	Required. The message body. 10,000 characters max.
.PARAMETER color
	The background color of the HipChat messag. One of "yellow", "red", "green", "purple", "gray", or "random". (default: yellow)
.PARAMETER notify
	Whether this message should trigger a user notification (change the tab color, play a sound, notify mobile phones, etc).
	Each recipient's notification preferences are taken into account. Defaults to false.
.PARAMETER messageFormat
	Determines how the message is treated by our server and rendered inside HipChat applications.
	html - Message is rendered as HTML and receives no special treatment. Must be valid HTML and entities must be escaped (e.g.: '&amp;' instead of '&').
		   May contain basic tags: a, b, i, strong, em, br, img, pre, code, lists, tables.
	text - Message is treated just like a message sent by a user. Can include @mentions, emoticons, pastes, and auto-detected URLs (Twitter, YouTube, images, etc).
	Valid values: html, text.
	Defaults to 'html'.
.PARAMETER apiHost
	The URI of the HipChat api (default: api.hipchat.com)
.EXAMPLE 
	Import-Module ./Publish-HipChatRoomNotification.psm1
	Import the module
.EXAMPLE	
	Get-Command -Module Publish-HipChatRoomNotification
	List available functions
.EXAMPLE
	Publish-HipChatRoomNotification -authToken "AUTH_TOKEN" -roomIdOrName "ROOM_ID_OR_NAME" -message "<div><a href=""#"">HTML link</a> example.</div>"
	Execute the module
#>
	[cmdletbinding()]
		Param(
			[Parameter(
				Position = 0,
				Mandatory = $True )]
				[string]$authToken,
			[Parameter(
				Position = 1,
				Mandatory = $True )]
				[string]$roomIdOrName,
			[Parameter(
				Position = 2,
				Mandatory = $True )]
				[string]$message,
			[Parameter(
				Position = 3,
				Mandatory = $False )]
				[string]$color,
			[Parameter(
				Position = 4,
				Mandatory = $False )]
				[string]$notify,
			[Parameter(
				Position = 5,
				Mandatory = $False )]
				[string]$messageFormat,
			[Parameter(
				Position = 6,
				Mandatory = $False )]
				[string]$apiHost
			)
	Begin
	{
		$DebugPreference = "Continue"
	}

	Process
	{
		Try
		{
			# prepare defaults
			if ($color -eq "")
			{
				$color = "yellow"
			}
			if ($apiHost -eq "")
			{
				$apiHost = "api.hipchat.com"
			}	
			if ($notify -eq "")
			{
				$notify = "false"
			}
			if ($messageFormat -eq "")
			{
				$messageFormat = "html"
			}

			# prepare JSON POST data
			$jsonTpl = """color"":""{0}"",""message_format"":""{1}"",""message"":""{2}"",""notify"":""{3}"""
			$message = $message.Replace("""", "\""")
			$post = [string]::Format($jsonTpl, $color, $messageFormat, $message, $notify)
			$post = ("{" + $post + "}")

			# prepare URL
			$roomIdOrName = [System.Uri]::EscapeDataString($roomIdOrName)
			$url = "http://$apiHost/v2/room/$roomIdOrName/notification"

			# prepare the HTTP web request
			$webRequest = [System.Net.WebRequest]::Create($url)
			$webRequest.ContentType = "application/json"
			$webRequest.Headers.Add("Authorization", "Bearer $authToken")
			$postStr = [System.Text.Encoding]::UTF8.GetBytes($post)
			$webRequest.Method = "POST"
			$webrequest.ContentLength = $postStr.Length			
			$requestStream = $webRequest.GetRequestStream()
			$requestStream.Write($postStr, 0,$postStr.length)
			$requestStream.Close()

			# run request
			[System.Net.WebResponse] $resp = $webRequest.GetResponse();
			$rs = $resp.GetResponseStream();
			[System.IO.StreamReader] $sr = New-Object System.IO.StreamReader -argumentList $rs;
			$result = $sr.ReadToEnd();
		}
		catch [Exception]
		{
			$result = "$_.Exception.ToString()"
		}
	}

	End
	{
		return $result | Format-Table 
	}
}
