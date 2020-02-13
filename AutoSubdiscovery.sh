#!/bin/bash
echo Enumeration
echo Subdomain enumeration
mkdir /root/Documents/Bug/$1 #change to where you want results stored
cd /opt/1.Recon/80.HTTP/1.Subdomain #change to where subdomain scripts are stored
python3 censys.py $1 | tee /root/Documents/Bug/$1/censys.txt
bash crt.sh $1 | tee /root/Documents/Bug/$1/crt.txt
python sublister/sublist3r.py -d $1 | tee /root/Documents/Bug/$1/sublist.txt
python knock/knockpy/knockpy.py $1 | tee /root/Documents/Bug/$1/knock.txt
amass enum -active -d unibet.co.uk | tee /root/Documents/Bug/$1/amass.txt
cd /root/go/bin
./assetfinder -subs-only $1 | tee /root/Documents/Bug/$1/assetfinder.txt
./hakrawler -url $1 -depth 5 -scope subs | tee /root/Documents/Bug/$1/hakrwaler.txt
cd /root/Documents/Bug/$1/
grep $1 sublist.txt | grep -v Enumerating > Subdomains.txt
mkdir done
mv sublist.txt done/sublist.txt
cat amass.txt >> Subdomains.txt
mv amass.txt done/amass.txt
cat assetfinder.txt >> Subdomains.txt
mv assetfinder.txt done/assetfinder.txt
grep unibet censys.txt >> Subdomains.txt
mv censys.txt done/censys.txt
grep sub hakrwaler.txt | cut -c 21- >> Subdomains.txt
mv hakrwaler.txt done/hakrwaler.txt
cat knock.txt | awk '{split($0,a,"\t"); print a[4];}' | grep -v Domain | grep -v -e "---" >> Subdomains.txt
mv knock.txt done/knock.txt
sort -u Subdomains.txt | grep 1 > Subsorted.txt
cat Subsorted.txt | /root/go/bin/httprobe | tee /root/Documents/Bug/$1/httprobe.txt
cat httprobe.txt | /opt/1.Recon/80.HTTP/2.Aquatone/aquatone
