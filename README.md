When you deal with a lot *HTTP* requests in your application, you want to have them as fast and light as possible. Also one want to take advantage of the *HTTP* keep alive functionality to reduce the number of reconnects to the hosting server if possible. Gzipping and other techniques are very welcome also. All this is especially interesting if your infrastructure is relying on this http communication heavily. *HTTP* is very good in providing a stable and flexibel solution, but sometimes suffers from the performance of native protocols.

The project I'm currently working on involves a lot of internal http communication. Therefore I wanted to have a look on the http client performance.
Because the client I used is implemented in *Ruby* I mostly compare ruby libs and versions. I also implemented a *Java* based http client implementation along with the benchmark to compare the results to a completely different setup. As a round up I added a test with [apache bench](http://httpd.apache.org/docs/2.0/programs/ab.html) and [httperf](http://www.hpl.hp.com/research/linux/httperf/) to see what a normal benchmark would tell us in time and throughput.

The tests consists of two things:

- The first step is to download a 16KB *json* asset from the remote server. The server in my tests is a separate system directly linked with a _cat.6 gigabit ethernet cable_. The remote is a 2.26 GHz Intel Core 2 Duo, 8 GB 1067 MHz DDR3. The main focus is on benchmarking library and stack efficiency.
- The second step is to parse these incoming data and grep a value and check this value for correctness. Sure, this is not possible in the case of *apache bench* and *httperf*.

For the json parsing i used the [yajl-ruby](https://github.com/brianmario/yajl-ruby) gem and included the *json* gem wrapper to leverage the *json* parser of *yajl* when possible and provided though the library. If the library doesn't have direct support for json parsing I implemented it by my self in a competitive manner.

In the *Java* world i used the [json simple](http://code.google.com/p/json-simple/) project from google code. The performance is nearly comparable to what ruby offers. I started the java test both in server and client mode.

I used the [apache](http://httpd.apache.org/) web server that is bundled with *MacOSX* (Version 10.6.7 - Apache/2.2.17).

I use *sessions* if the library provides it. The test will be executed _10.000_ times. 

The results and objective of the benchmark is to measure the user and system time used during the execution of the requests and the throughput that could be generated.

The whole test scenario can be found on [github](https://github.com/threez/test-http-clients). To run the test suite on your mashine simple run:

    make

The results I found out during my observations is pretty impressive. *Ruby* actually doesn't have to hide itself in these benchmarks when using the native libraries that are empowered using [libcurl](http://curl.haxx.se/libcurl/).
Here are the facts:

* using *Java* one can achieve around *7,3 MB/s* and approximately *460 requests/s*
* using *Ruby* around *13,9 MB/s* and approximately *876 requests/s* are possible

Native applications without json parsing:

* *apache bench* produces less throughput (*12,7 MB/s*) than *Ruby* and approximately *766 requests/s*
* the best results can be achieved using *httperf* around *18 MB/s* and approximately *1091 requests/s*

Ruby has a bunch of native http libraries that perform very well when doing a lot of blocking http calls. For me [curb](http://curb.rubyforge.org/) and [patron](https://github.com/taf2/curb) are the best choise. Even if they may miss some functionality (certificate authentication in patron) or convenience (curb sessions). Java has also good numbers but can not compete with the native libraries on the same level.

<img src="http://toevolve.org/images/posts/2011-04-26-throughput.png" alt="Throughput MB/s"/>
<img src="http://toevolve.org/images/posts/2011-04-26-real-time.png" alt="Real Time (s)"/>
<img src="http://toevolve.org/images/posts/2011-04-26-user-system-time.png" alt="User + System Time (s)"/>
<img src="http://toevolve.org/images/posts/2011-04-26-table.png" alt="All Data"/>
