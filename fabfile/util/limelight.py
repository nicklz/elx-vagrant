import urllib2
import time
import hmac
import hashlib
import logging
try: import simplejson as json 
except ImportError: import json

#LOG_FILENAME = "purge-api.log"

class PurgeApi:
	def __init__(self,baseUrl,username,apiKey):
		self.baseUrl = baseUrl
		self.username = username
		self.apiKey = apiKey 
		#logging.basicConfig(filename=LOG_FILENAME,level=logging.DEBUG)
	def getEntitlements(self):
		return self.get("purgeEntitlements")
	def getStatusByShortname(self,shortname,includeDetail=False,pageSize=50,startItem=0): 
		uri = "statusList/"+shortname+"?includeDetail="+str(includeDetail)
		uri += "&dataLimit=" + str(pageSize)
		uri += "&offset=" + str(startItem)
		return self.get(uri)
	def getStatusById(self,purgeId,includeDetail=False,pageSize=50,startItem=0): 
		uri = "requestStatus/"+str(purgeId)+"?includeDetail="+str(includeDetail)
		uri += "&dataLimit=" + str(pageSize)
		uri += "&offset=" + str(startItem)
		return self.get(uri)
	def createRequest(self,purgeRequest):
		uri = "request"
		return self.post(uri,json.dumps(purgeRequest)) 
	def get(self,uri):
		opener = self.__getOpener()
		request = self.__buildRequest("GET",self.baseUrl+uri,"") 
		connection = opener.open(request)
		response = connection.read() 
		logging.debug("Response: " + response)
		return json.loads(response)
	def post(self,uri,data):
		opener = self.__getOpener()
		request = self.__buildRequest("POST",self.baseUrl+uri,data) 
		connection = opener.open(request)
		response = connection.read()
		logging.debug("Response: " + response)
		return json.loads(response)
	def __getOpener(self):
		return urllib2.build_opener(urllib2.HTTPHandler)
	def __generateHmac(self,data):
		return hmac.new(self.apiKey.decode('hex'), msg=data, digestmod=hashlib.sha256).hexdigest() 
	def __buildRequest(self,requestType,url,data):
		logging.debug(requestType + ": " + url + " with data: " + data) 
		request = urllib2.Request(url,data=data)
		request.get_method = lambda:requestType 
		request.add_header('Content-Type','application/json') 
		request.add_header('Accept','application/json') 
		request.add_header('X-LLNW-Security-Principal',self.username) 
		timestamp = str(int(round(time.time()*1000))) 
		request.add_header('X-LLNW-Security-Timestamp',timestamp) 
		urlForHmac = url.partition("?")[0]
		logging.debug("Url For Hmac: " + urlForHmac) 
		queryParamsForHmac = url.partition("?")[2]		
		logging.debug("Query Params For Hmac: " + queryParamsForHmac) 
		request.add_header('X-LLNW-Security-Token', self.__generateHmac(requestType + urlForHmac + queryParamsForHmac + timestamp + data)) 
		logging.debug("Headers: " + str(request.headers))
		return request 