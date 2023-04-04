# Usefull commands

## get the CF API token from the cluster

`export CF_API_TOKEN=$(k -n external-dns get secrets cf-token -o json | jq -r .data.cloudflare_api_token | base64 -d)`

On windows use:

`k -n external-dns get secrets cf-token -o json | jq -r .data.cloudflare_api_token | C:\srdev\tools\Git-2.38.0\usr\bin\base64.exe -d 2>$nil`
