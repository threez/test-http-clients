package org.toevolve.httptest;

import java.net.URL;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;
import org.json.simple.JSONArray;
import org.json.simple.JSONValue;

public class ApacheHttpClient extends TestApplication {

	private HttpClient client;
	
	public ApacheHttpClient() {
		client = new HttpClient();
	}
	
	public static void main(String[] args) throws Exception {
		ApacheHttpClient app = new ApacheHttpClient();
		doTest("testing httpclient", args, app);
	}

	void testRequest(URL url) throws Exception {
		client.startSession(url.getHost(), url.getPort() == -1 ? url.getDefaultPort() : url.getPort());
		HttpMethod doGet = new GetMethod(url.getPath());
		client.executeMethod(doGet);
		verifyResult((JSONArray)JSONValue.parse(doGet.getResponseBodyAsString()));
		
		client.endSession();
	}

}


