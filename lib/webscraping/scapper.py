from flask import Flask, request, jsonify
from bs4 import BeautifulSoup
import requests

# Init app
app = Flask(__name__)

@app.route('/', methods=['GET'])
def getBases():
    data = {}
    inputTH = request.args['townHallLevel']
    inputBT = request.args['baseType']
    # get the url based on townhall level and base type
    baseUrl = f"https://cocbases.com/best-th{inputTH}-{inputBT}-base/"
    if (inputTH == '6' or inputTH == '8' or inputTH == '9') and inputBT == 'war':
        baseUrl = f"https://cocbases.com/th{inputTH}-{inputBT}-base-anti-everything/"

    elif (inputTH == '13' and inputBT == 'war') or (inputTH == '11' and inputBT == 'trophy'):
        baseUrl = f"https://cocbases.com/th{inputTH}-{inputBT}-base-links/"

    elif inputTH == '12' and (inputBT == 'hybrid' or inputBT == 'trophy'):
        baseUrl = f"https://cocbases.com/th{inputTH}-{inputBT}-base-link/"

    elif (inputTH == '7'  and inputBT == 'farming') or (inputTH == '9' and inputBT == 'trophy'):
        baseUrl = f"https://cocbases.com/th{inputTH}-{inputBT}-bases/"

    headers = {
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1.1 Safari/605.1.15"
    }
    response = requests.get(baseUrl, headers=headers)
    soup = BeautifulSoup(response.content, "html.parser")
    # gets the urls to clash website for users to copy the base
    copyUrl = soup.select('div.su-button-center > a')
    # gets the url of all base images
    potentialBaseUrls = soup.find_all("div", {'class': 'wp-caption'})

    baseUrl = []
    for base in potentialBaseUrls:
        baseContents = base.contents
        if baseContents[0].has_attr('href'):
            baseUrl.append(baseContents[0]['href'])
        elif baseContents[0].has_attr('src'):
            baseUrl.append(baseContents[0]['src'])
    # merges the base image url and copy url in to a list w/ each index has the base image with the corresponding copy link
    urlData = []
    for index in range(1, len(copyUrl)):
        base = {}
        base['baseUrl'] = baseUrl[index]
        base['copyUrl'] = copyUrl[index]['href']
        urlData.append(base)

    data['townHallLevel'] = inputTH
    data['baseType'] = inputBT
    data['urls'] = urlData
    return jsonify(data)
    
# Run Server
if __name__ == '__main__':
    app.run(debug=True)