package org.toevolve.httptest;

import java.net.URL;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;
import org.json.simple.JSONArray;
import org.json.simple.JSONValue;

public class ApacheHttpClient extends TestApplication {

	private HttpClient client;
	
	public static void main(String[] args) throws Exception {
	  ApacheHttpClient app = new ApacheHttpClient();
		doTest("testing httpclient", args, app);
	}
	
	void prepare(URL url) throws Exception {
  	client = new HttpClient();
  	int port = url.getPort() == -1 ? url.getDefaultPort() : url.getPort();
    client.startSession(url.getHost(), port);
  }

	void testRequest(URL url) throws Exception {
		HttpMethod doGet = new GetMethod(url.getPath());
		client.executeMethod(doGet);
		verifyResult((JSONArray)JSONValue.parse(doGet.getResponseBodyAsString()));	
	}

  void tearDown() throws Exception {
		client.endSession();
  }
}


