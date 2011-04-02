package org.toevolve.httptest;

import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import java.lang.management.*;

public abstract class TestApplication {
	/** code from http://nadeausoftware.com/articles/2008/03/java_tip_how_get_cpu_and_user_time_benchmarking **/
	
	/** Get CPU time in nanoseconds. */
	static public long getCpuTime( ) {
	    ThreadMXBean bean = ManagementFactory.getThreadMXBean( );
	    return bean.isCurrentThreadCpuTimeSupported( ) ?
	        bean.getCurrentThreadCpuTime( ) : 0L;
	}
	 
	/** Get user time in nanoseconds. */
	static public long getUserTime( ) {
	    ThreadMXBean bean = ManagementFactory.getThreadMXBean( );
	    return bean.isCurrentThreadCpuTimeSupported( ) ?
	        bean.getCurrentThreadUserTime( ) : 0L;
	}

	/** Get system time in nanoseconds. */
	static public long getSystemTime( ) {
	    ThreadMXBean bean = ManagementFactory.getThreadMXBean( );
	    return bean.isCurrentThreadCpuTimeSupported( ) ?
	        (bean.getCurrentThreadCpuTime() - bean.getCurrentThreadUserTime( )) : 0L;
	}
	
	static void doTest(String name, String[] args, TestApplication app)
			throws Exception {
		int iterations = Integer.parseInt(args[0]);
		URL url = new URL(args[1]);

		// start time
		long sTime = System.currentTimeMillis();
		long startSystemTimeNano = getSystemTime();
		long startUserTimeNano   = getUserTime();
		
		app.prepare(url);
		// do the test
		for (int i = 0; i < iterations; ++i) {
			app.testRequest(url);
		}
		app.tearDown();
		
		// end time
		long taskUserTimeNano    = getUserTime() - startUserTimeNano;
		long taskSystemTimeNano  = getSystemTime() - startSystemTimeNano;
		long eTime = System.currentTimeMillis();
		
		double userSec = (taskUserTimeNano - startSystemTimeNano) / (1000.0 * 1000.0 * 1000.0);
		double systemSec = (taskSystemTimeNano - startSystemTimeNano) / (1000.0 * 1000.0 * 1000.0);
		double totalSec = userSec + systemSec;
		double realSec = (eTime - sTime) / 1000.0;
		
		// print the results
		System.out.println("Time for " + iterations + " requests to " + url + ":");		
		System.out.println("                          user     system      total        real");
		System.out.println(String.format("%-19s %10.6f %10.6f %10.6f (%10.6f)", new Object[] {
				name, new Double(userSec), new Double(systemSec), 
				new Double(totalSec), new Double(realSec)
		}));
	}

	void verifyResult(JSONArray array) {
		JSONObject firstObject = (JSONObject)array.get(0);
		long value = ((Long)firstObject.get("numbers")).longValue();
		
		
		if (value != 123123) {
			throw new RuntimeException("expected 123123 as number, something is wrong");
		}
	}

  abstract void prepare(URL url) throws Exception;

	abstract void testRequest(URL url) throws Exception;
	
	abstract void tearDown() throws Exception;
}
