#simple greynoise json export parser
#also shows how to call a REST API (supid for real usage as we are reading the json extract)
# this is basic AF but you know.. make it better if you want :P
# luv from mRr3b00t (who is tired fuck #log4shell)

write-host "####################################" -ForegroundColor Cyan
$apikey = "" #don't lose your API key
#Simple API Call
$headers = @{'key' = $apikey.ToString() ;'Accept' = 'application/json';'User-Agent' = 'HelloFriend'}

write-host "Importing GreyNoise JSON Export" -ForegroundColor Green
$import = Get-Content .\gn_analysis_2021-12-18-0247.json | ConvertFrom-Json
write-host "Searching json file for bad pews" -ForegroundColor Green
foreach($item in $import){

if($item.classification -eq "malicious"){
write-host "Bad Pews Detected" -ForegroundColor DarkRed
write-host $item.ip -ForegroundColor Red

$ip2check = $item.ip.ToString()
$greynoiseapi = ("https://api.greynoise.io/v2/noise/quick/$ip2check")

#Now this is silly because its pointless but it's a demo!
$apicall = Invoke-RestMethod -Uri $greynoiseapi -Headers $headers -Verbose -Debug -Body (ConvertTo-Json $data) -Method Get
$apicall.noise
$apicall.code

#sleep a bit - you need to adjust this
Start-Sleep 1
#you will need to expand some of these below
#write-host $item.classification
#write-host $item.actor
#write-host $item.firstSeen
#write-host $item.lastSeen
#write-host $item.vpn
#write-host $item.vpnService
#write-host $item.bot
#write-host $item.cve
#write-host $item.tags
#write-host $item.metadata
#write-host $item.rawData
}

}


