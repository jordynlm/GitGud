import requests
import re
import sys

file = open(sys.argv[1],'r')
contents = file.readlines()
print(contents)
query=contents[-1]
print(query)
print("Searching Stack Overflow for error message: " + query)
querynoquotes= query.replace("\"","").replace("\'","")
queryplus = querynoquotes.replace(" ","+")
url = "https://stackoverflow.com/search?q="+queryplus
print("Search URL "+ url)
a = requests.get(url)
resultspage = a.text
result_ids = re.findall("(?<=question\-summary\-)\d*",resultspage)
if len(result_ids) ==0:
	print("No results found on Stack Overflow.")
	sys.exit()
topresulturl = "https://stackoverflow.com/questions/" + result_ids[0]
topresult = requests.get(topresulturl).text
topresultanswers = re.findall("(?<=<div class=\"post-text\" itemprop=\"text\">)[\s\S]*?(?=</div>)",topresult)
print(topresultanswers[1])

