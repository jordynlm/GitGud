import requests
import re
import sys

query=""
for line in sys.stdin:
    query+=line
    
print("QUERY IS " + query)
queryplus = query.replace(" ","+")
a = requests.get("https://stackoverflow.com/search?q="+queryplus)
resultspage = a.text
result_ids = re.findall("(?<=question\-summary\-)\d*",resultspage)
topresulturl = "https://stackoverflow.com/questions/" + result_ids[0]
topresult = requests.get(topresulturl).text
topresultanswers = re.findall("(?<=<div class=\"post-text\" itemprop=\"text\">)[\s\S]*?(?=</div>)",topresult)
print(topresultanswers[1])
print('done')


