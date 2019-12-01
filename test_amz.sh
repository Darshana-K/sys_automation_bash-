
amz_t=$(cat amazon-token.txt)
flx_id=$(cat flex-id.txt)
ses_t=$(cat session-token.txt)
while ! grep "TokenException" output.txt > /dev/null
do
echo -e '\n'$(date +%x_%H:%M:%S:%3N) > output.txt
curl -s -H 'Host: flex-capacity-na.amazon.com' -H 'Cookie: session-token="'"$ses_t"'"' -H 'x-amz-access-token: "'"$amz_t"'"' -H 'x-flex-instance-id: "'"$flx_id"'"' -H 'Accept: */*' -H 'User-Agent: iOS/10.2.2 (iPhone Darwin) Model/iPhone Platform/iPhone6,1 RabbitiOS/2.0.141' -H 'Accept-Language: en-us' --compressed 'https://flex-capacity-na.amazon.com/GetOffersForProvider?serviceAreaIds=***WAREHOUSEID***' >> output.txt
if grep -q "OFFERED" output.txt; then
cat output.txt >> foundblocks.txt
./getlast.bat
./getit.bat
if [ ! -f pageflag.txt ]; then
/usr/bin/php flexalert.php
echo "paged" > pageflag.txt
fi
fi
done
/usr/bin/php flexover.php



curl -s -H 'Host: flex-capacity-na.amazon.com' -H 'Cookie: session-token=jef6+LhZs9eJjOx5a/57RrbPVeoUDRHcJpAXZCL2ZUc2Dtz6rtVMjHqX/R+hoXbrFISCBEjpgKxW/FV9D3fcdeJ8gXRvxOa4XiE+va0TGKtQTGw8p9lQRaqI/CuRvIiBq8UUvSo+QUHf0+vvQCp20KzziZjH9XpXCwj0YMkr+ad5Gs3Bw2AR8uqspDfEgEQzO2/Sm57weOArnw6q2jWuaJOmRenqzu7M0KDtBc3wFyA=' -H 'x-amz-access-token:Atna|EwICIBz1NWrw1vzHf0DdShFN8UI9F1hL6YqIHvwLXf1DQKzLmhIciZWXfdI8o8G2CZFDgDtf3ZGhgu6-oLKlx07yY5v93_yjSMfSsFGI2uMw7CIwSj2Y7AoMZ0_e_ukdfvkF4XuW_-dKXAPGWuLIgtEbMoJ7P474_u7ro6GR6UH9gCe1YTJmBSurp3nAgCKahE4mhCdP9PwWEpJfFAFy5kBg-8HSd5TjyF98pqtEozEV_gkNGaxKK5QaQpBuKke4qNZET8TrJsh1_8p2qwhf73bX3ZXRoRdap1ZRCnijyQ3RPN_346uC7lHcu1pZVoz9T19Ekwaa_YPtp1MEQsumxVPu9uWrveuebURXG_SXJQYqi-XBgQ' -H 'x-flex-instance-id:C68E8E2A-615D-407C-8379-AF41774CFA03' -H 'Accept: */*' -H 'User-Agent: iOS/10.2.2 (iPhone Darwin) Model/iPhone Platform/iPhone6,1 RabbitiOS/2.0.141' -H 'Accept-Language: en-us' --compressed 'https://flex-capacity-na.amazon.com/GetOffersForProvider?serviceAreaIds=27' >> output.txt