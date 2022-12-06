#!/bin/bash
cd ~
wget https://download.visualstudio.microsoft.com/download/pr/67ca3f83-3769-4cd8-882a-27ab0c191784/bf631a0229827de92f5c026055218cc0/dotnet-sdk-6.0.403-linux-arm64.tar.gz -O ~/dotnet-sdk.tar.gz
tar -xzf ~/dotnet-sdk.tar.gz 
cd dotnet*
mv * /usr/local/bin
exec /bin/bash
echo "Script done"
