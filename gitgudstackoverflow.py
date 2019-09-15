import requests
import re
import sys

print(sys.argv[1:])
query=" ".join(sys.argv[1:])
print("Searching Stack Overflow for error message: " + query)
queryplus = query.replace(" ","+")
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

