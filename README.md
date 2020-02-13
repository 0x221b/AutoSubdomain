# AutoSubdomain
Script to auto run a few subdomain enumeration tools and combine results in single list

Tools run: 
sublist3r
assetfinder
censys.py
hakrawler
knockpy
amass

It then combines results and puts them through 
httprobe
aquatone

You will need to edit the directory listings to suit your personal preference

Usage:

./AutoSubdomain.sh <domain>


To do:
Add script to install all appropriate tools if not found
Run as cronjob and the diff to previous day then send alerts to slack
