---
title: 'Build Native App with Quarkus'
subtitle: 'A simple echo app using resteasy and swagger with quarkus'
summary: A simple echo app using resteasy and swagger with quarkus
authors:
- jjbeto
tags:
- Java
- Quarkus
- Tutorial
date: "2019-12-07T14:00:00Z"
diagram: true
featured: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Placement options: 1 = Full column width, 2 = Out-set, 3 = Screen-width
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  placement: 1
  caption: 'Credit: [**Atom**](https://onextrapixel.com/best-atom-packages-web-developers/)'
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---
<aside>
<div class="ox-hugo-toc toc">
<header>
<h2>Table of Contents</h2>
</header>
- [1. Overview](#overview)
- [2. Echo App](#echo-app)
- [3. Project Generation](#project-generation)
- [4. Swagger](#swagger)
- [5. DockerHub](#dockerhub)
- [6. Conclusion](#conclusion)
</div>
</aside>
<!--endtoc-->

## 1. Overview {#overview}

I want to talk about **Microservices**, but then I just found out that actually I don't have much opensource material published, like **one microservice alone**.

Because of that I've decided to create one from scratch, which I can reuse in next articles for cool stuff 😝

For this I just choose a really interesting project to use as base: [Quarkus](https://quarkus.io/).

The idea is to create a simple Echo service, which I'm able to set a timer to get back a response.

## 2. Echo App {#echo-app} 

A simple REST endpoint that return the same text provided as parameter. It's also possible to ask for a waiting time to get responses.

You can find the complete source code of this sample [on my GitHub](https://github.com/jjbeto/echo), and you can also:

- Pull from [DockerHub](https://hub.docker.com/r/jjbeto/echo)
- Access the running app on [Heroku]()

## 3. Project Generation {#project-generation}

I did follow the instructions on [Quarkus Docs](https://quarkus.io/guides/openapi-swaggerui), as follows:

1. Create base project

```bash
mvn io.quarkus:quarkus-maven-plugin:1.0.1.Final:create \
    -DprojectGroupId=com.jjbeto \
    -DprojectArtifactId=echo \
    -DclassName=com.jjbeto.echo.EchoResource \
    -Dpath=/echo \
    -Dextensions=resteasy-jsonb
```

2. Remove .mvn from git: added `.mvn` on `.gitignore`

3. Create basic logic: returns the same text provided as a response and accepts a query parameter to set a wait time to return the response.
    
    - Change to use root as base endpoint;
    - Returns the message path parameter back to the caller;
    - Add waiting time to respond as a query parameter;

## 4. Swagger {#swagger}

Let's make it better for 3th party usage, adding swagger descriptions to "teach" how to use the API! It's easy with Quarkus as you can see [in the documentation](https://quarkus.io/guides/openapi-swaggerui).

Firstly we need to add Swagger to the project running the following command in the root folder:

```bash
./mvnw quarkus:add-extension -Dextensions="openapi"
```

But I don't like the endpoint generated `/openapi` 😒, instead I'm going to use `/swagger`, so we can add this property to `application.properties`:

```properties
quarkus.smallrye-openapi.path=/swagger
```

The `/swagger` endpoint is going to deliver the Yaml file describing the API.

I want to activate SwaggerUI also:

```properties
quarkus.swagger-ui.always-include=true
```

The default endpoint for SwaggerUI is [http://localhost:8080/swagger-ui](http://localhost:8080/swagger-ui)

Nice! Now let's move on and add some descriptions for API users to know how to handle it. According to the [specification](https://swagger.io/specification/), we need to use the `openapi.yml` to add custom information:

1. Access `http://localhost:8080/swagger` and download `openapi.yml`
2. Save `openapi.yml` at `./src/main/resources/META-INF`
3. Add some descriptions and API info

Now you can access it again via [http://localhost:8080/swagger-ui](http://localhost:8080/swagger-ui) and check the result 😃

## 5. DockerHub {#dockerhub}

I want to turn it possible that anyone can go to DockerHub and pull the final image of my Echo app.

### Build the Native Image

Quarkus let us build a complete native app, with no JVM needed to run. It is awesome mainly for a simple app like Echo, because it's going to be crazing fast and in a incredible small and light image.

To build the native image we need to have the pre-requisite setup as mentioned on [Quarkus docs](https://quarkus.io/guides/building-native-image), please follow the steps before continuing.

Notes: please be aware of the compatibility of GraalVM and the current Quarkus framework. Quarkus is always trying to be as close as possible to the last GraalVM build but you need to check if they are already compatible with the current version. At this moment the last build of GraalVM is 19.3.0.r11 and Quarkus is compatible only with **GraalVM 19.2.1**.

After install GraalVM (I did using [sdkman](https://sdkman.io/)), Docker (or podman) and its dependencies, you can build the native package with this command:

```bash
./mvnw package -Pnative -Dquarkus.native.container-build=true
```

According to **Quarkus** the build process is pretty much simple: 

![Quarkus Build Process](https://quarkus.io/guides/images/native-executable-process.png)

So TL;TR it's exactly like building a fat jar, but the execution to build a native app takes more time (and need more resources), 

#### Important Notes on Build Process

When building the native image with Docker on my Mac, I was getting this error:

```bash
docker run -v /Users/beto/IdeaProjects/opensource/echo/target/echo-1.0-SNAPSHOT-native-image-source-jar:/project:z --rm quay.io/quarkus/ubi-quarkus-native-image:19.2.1 -J-Djava.util.logging.manager=org.jboss.logmanager.LogManager -J-Dsun.nio.ch.maxUpdateArraySize=100 -J-Dvertx.logger-delegate-factory-class-name=io.quarkus.vertx.core.runtime.VertxLogDelegateFactory -J-Dvertx.disableDnsResolver=true -J-Dio.netty.leakDetection.level=DISABLED -J-Dio.netty.allocator.maxOrder=1 --initialize-at-build-time= -H:InitialCollectionPolicy=com.oracle.svm.core.genscavenge.CollectionPolicy$BySpaceAndTime -jar echo-1.0-SNAPSHOT-runner.jar -J-Djava.util.concurrent.ForkJoinPool.common.parallelism=1 -H:FallbackThreshold=0 -H:+ReportExceptionStackTraces -H:-AddAllCharsets -H:EnableURLProtocols=http -H:-JNI --no-server -H:-UseServiceLoaderFeature -H:+StackTrace echo-1.0-SNAPSHOT-runner
[echo-1.0-SNAPSHOT-runner:25]    classlist:  12,165.10 ms
[echo-1.0-SNAPSHOT-runner:25]        (cap):   1,720.23 ms
[echo-1.0-SNAPSHOT-runner:25]        setup:   3,699.11 ms
14:23:23,903 INFO  [org.jbo.threads] JBoss Threads version 3.0.0.Final
[echo-1.0-SNAPSHOT-runner:25]   (typeflow):  17,087.39 ms
[echo-1.0-SNAPSHOT-runner:25]    (objects):  12,944.17 ms
[echo-1.0-SNAPSHOT-runner:25]   (features):     489.73 ms
[echo-1.0-SNAPSHOT-runner:25]     analysis:  31,843.79 ms
[echo-1.0-SNAPSHOT-runner:25]     (clinit):     622.07 ms
[echo-1.0-SNAPSHOT-runner:25]     universe:   1,768.77 ms
[echo-1.0-SNAPSHOT-runner:25]      (parse):  42,885.71 ms
[echo-1.0-SNAPSHOT-runner:25]     (inline):  49,278.76 ms
[echo-1.0-SNAPSHOT-runner:25]    (compile):  53,007.49 ms
[echo-1.0-SNAPSHOT-runner:25]      compile: 158,081.96 ms
Error: Image build request failed with exit status 137
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  03:55 min
[INFO] Finished at: 2019-12-07T15:26:48+01:00
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal io.quarkus:quarkus-maven-plugin:1.0.1.Final:build (default) on project echo: Failed to build a runnable JAR: Failed to augment application classes: Build failure: Build failed due to errors
[ERROR]         [error]: Build step io.quarkus.deployment.pkg.steps.NativeImageBuildStep#build threw an exception: java.lang.RuntimeException: Failed to build native image
[ERROR]         at io.quarkus.deployment.pkg.steps.NativeImageBuildStep.build(NativeImageBuildStep.java:289)
[ERROR]         at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
[ERROR]         at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
[ERROR]         at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
[ERROR]         at java.lang.reflect.Method.invoke(Method.java:498)
[ERROR]         at io.quarkus.deployment.ExtensionLoader$1.execute(ExtensionLoader.java:941)
[ERROR]         at io.quarkus.builder.BuildContext.run(BuildContext.java:415)
[ERROR]         at io.quarkus.builder.BuildContext$$Lambda$109.0000000055C01130.run(Unknown Source)
[ERROR]         at org.jboss.threads.ContextClassLoaderSavingRunnable.run(ContextClassLoaderSavingRunnable.java:35)
[ERROR]         at org.jboss.threads.EnhancedQueueExecutor.safeRun(EnhancedQueueExecutor.java:2011)
[ERROR]         at org.jboss.threads.EnhancedQueueExecutor$ThreadBody.doRunTask(EnhancedQueueExecutor.java:1535)
[ERROR]         at org.jboss.threads.EnhancedQueueExecutor$ThreadBody.run(EnhancedQueueExecutor.java:1426)
[ERROR]         at java.lang.Thread.run(Thread.java:819)
[ERROR]         at org.jboss.threads.JBossThread.run(JBossThread.java:479)
[ERROR] Caused by: java.lang.RuntimeException: Image generation failed
[ERROR]         at io.quarkus.deployment.pkg.steps.NativeImageBuildStep.build(NativeImageBuildStep.java:278)
[ERROR]         ... 13 more
[ERROR] -> [Help 1]
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoExecutionException
```

I fount an issue on [Quarkus GitHub](https://github.com/quarkusio/quarkus/issues/1140) related to it and, when I changed my Docker env to use 3Gb (instead of 2Gb by default), the build worked:

```bash
docker run -v /Users/beto/IdeaProjects/opensource/echo/target/echo-1.0-SNAPSHOT-native-image-source-jar:/project:z --rm quay.io/quarkus/ubi-quarkus-native-image:19.2.1 -J-Dsun.nio.ch.maxUpdateArraySize=100 -J-Djava.util.logging.manager=org.jboss.logmanager.LogManager -J-Dvertx.logger-delegate-factory-class-name=io.quarkus.vertx.core.runtime.VertxLogDelegateFactory -J-Dvertx.disableDnsResolver=true -J-Dio.netty.leakDetection.level=DISABLED -J-Dio.netty.allocator.maxOrder=1 --initialize-at-build-time= -H:InitialCollectionPolicy=com.oracle.svm.core.genscavenge.CollectionPolicy$BySpaceAndTime -jar echo-1.0-SNAPSHOT-runner.jar -J-Djava.util.concurrent.ForkJoinPool.common.parallelism=1 -H:FallbackThreshold=0 -H:+ReportExceptionStackTraces -H:-AddAllCharsets -H:EnableURLProtocols=http -H:-JNI --no-server -H:-UseServiceLoaderFeature -H:+StackTrace echo-1.0-SNAPSHOT-runner
[echo-1.0-SNAPSHOT-runner:24]    classlist:   8,587.26 ms
[echo-1.0-SNAPSHOT-runner:24]        (cap):   1,512.26 ms
[echo-1.0-SNAPSHOT-runner:24]        setup:   3,112.68 ms
14:29:25,687 INFO  [org.jbo.threads] JBoss Threads version 3.0.0.Final
[echo-1.0-SNAPSHOT-runner:24]   (typeflow):  19,795.33 ms
[echo-1.0-SNAPSHOT-runner:24]    (objects):  17,973.88 ms
[echo-1.0-SNAPSHOT-runner:24]   (features):     486.83 ms
[echo-1.0-SNAPSHOT-runner:24]     analysis:  39,734.95 ms
[echo-1.0-SNAPSHOT-runner:24]     (clinit):     582.32 ms
[echo-1.0-SNAPSHOT-runner:24]     universe:   2,178.24 ms
[echo-1.0-SNAPSHOT-runner:24]      (parse):   5,333.97 ms
[echo-1.0-SNAPSHOT-runner:24]     (inline):   9,494.69 ms
[echo-1.0-SNAPSHOT-runner:24]    (compile):  29,119.41 ms
[echo-1.0-SNAPSHOT-runner:24]      compile:  46,351.15 ms
[echo-1.0-SNAPSHOT-runner:24]        image:   3,879.22 ms
[echo-1.0-SNAPSHOT-runner:24]        write:   2,057.79 ms
[echo-1.0-SNAPSHOT-runner:24]      [total]: 106,328.41 ms
[INFO] [io.quarkus.deployment.QuarkusAugmentor] Quarkus augmentation completed in 111589ms
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  02:00 min
[INFO] Finished at: 2019-12-07T15:30:59+01:00
[INFO] ------------------------------------------------------------------------
```

#### Prepare the Image

To generate the image locally we can run from root folder:

```bash
docker build -f src/main/docker/Dockerfile.native -t jjbeto/echo .
```

The output is:

```bash
Sending build context to Docker daemon  36.77MB
Step 1/6 : FROM registry.access.redhat.com/ubi8/ubi-minimal
latest: Pulling from ubi8/ubi-minimal
645c2831c08a: Pull complete 
5e98065763a5: Pull complete 
Digest: sha256:32fb8bae553bfba2891f535fa9238f79aafefb7eff603789ba8920f505654607
Status: Downloaded newer image for registry.access.redhat.com/ubi8/ubi-minimal:latest
 ---> 469119976c56
Step 2/6 : WORKDIR /work/
 ---> Running in 4f74acf2fa46
Removing intermediate container 4f74acf2fa46
 ---> fc9bee94a0d0
Step 3/6 : COPY target/*-runner /work/application
 ---> b9a029618b01
Step 4/6 : RUN chmod 775 /work
 ---> Running in a37dd1eda18d
Removing intermediate container a37dd1eda18d
 ---> a686c7dba3ed
Step 5/6 : EXPOSE 8080
 ---> Running in 21f6e36ba8cb
Removing intermediate container 21f6e36ba8cb
 ---> 5d0d75543315
Step 6/6 : CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]
 ---> Running in 8a2dd88f45b2
Removing intermediate container 8a2dd88f45b2
 ---> 33592d7cd99d
Successfully built 33592d7cd99d
Successfully tagged jjbeto/echo:latest
```

And if you list the local docker images:

```bash
docker images
REPOSITORY       TAG                 IMAGE ID            CREATED             SIZE
jjbeto/echo      latest              33592d7cd99d        12 seconds ago      142MB
```

Now we can finally run our image on Docker:

```bash
docker run -i --rm -p 8080:8080 jjbeto/echo
```

And the output is:

```bash
2019-12-07 14:48:13,719 INFO  [io.quarkus] (main) echo 1.0-SNAPSHOT (running on Quarkus 1.0.1.Final) started in 0.012s. Listening on: http://0.0.0.0:8080
2019-12-07 14:48:13,719 INFO  [io.quarkus] (main) Profile prod activated. 
2019-12-07 14:48:13,719 INFO  [io.quarkus] (main) Installed features: [cdi, resteasy, resteasy-jsonb, smallrye-openapi, swagger-ui]
```

Awesome! And we can reach the service on localhost:

{{< figure src="localhost-8080.png" title="Localhost running on port 8080" >}}

But... The image is still too big! 142MB is not a good size for such small service.. Right?

I changed the `.src/main/docker/Dockerfile.native` to use only the minimum files from `debian:10-slim`, following a [very nice tip](https://github.com/quarkusio/quarkus/issues/326):

```
## Stage 1 : intermediate container to copy the needed dynamic libraries
FROM debian:10-slim AS debian

## Stage 2 : create the final docker image
FROM scratch
COPY target/*-runner /bin/app
COPY --from=debian /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2
COPY --from=debian /lib/x86_64-linux-gnu/ld-2.28.so \
    /lib/x86_64-linux-gnu/libm.so.6 /lib/x86_64-linux-gnu/libm-2.28.so \
    /lib/x86_64-linux-gnu/libpthread.so.0 /lib/x86_64-linux-gnu/libpthread-2.28.so \
    /lib/x86_64-linux-gnu/libdl.so.2 /lib/x86_64-linux-gnu/libdl-2.28.so \
    /lib/x86_64-linux-gnu/libz.so.1 /lib/x86_64-linux-gnu/libz.so.1.2.11 \
    /lib/x86_64-linux-gnu/librt.so.1 /lib/x86_64-linux-gnu/librt-2.28.so \
    /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/libc-2.28.so \
    /lib/x86_64-linux-gnu/
EXPOSE 8080
CMD ["/bin/app", "-Dquarkus.http.host=0.0.0.0"]
```

And now my image has a more reasonable size: 44.5MB

```bash
docker images
REPOSITORY        TAG                 IMAGE ID            CREATED             SIZE
jjbeto/echo       latest              3d7de934bcd4        29 seconds ago      44.5MB
```

But the final result on DockerHub is different:

{{< figure src="dockerhub.png" title="Image on DockerHub" >}}

15MB?? Now we are talking!! 😎

Do you know how to make it even smaller? Please drop a message! 📫

#### How to Publish on DockerHub?

To publish the image on DockerHub is pretty simple:

1. Login by `docker login` and give your username/password
2. Push the local image to remote using the command `docker push <image_name>`, in my case it was `docker push jjbeto/echo`
3. Go to [DockerHub](https://hub.docker.com/r/jjbeto/echo) and check it 🎉

## 6. Conclusion {#conclusion}

Quarkus is an amazing tool and brings a lot of power to the Java world in my opinion. It's easy to use, has already a lot of built-in tools (like Spring-Boot maybe?) that make it possible to build good apps in a fraction of time.

But please don't be silly, Quarkus is not for everyone and not for everything! As it's using GraalVM you can't use any library out there, because you can have reflection problems for example.

If you can use Quarkus library standards, Quarkus is for sure something to consider for your project.

About the Echo App, it was a good choice to use Quarkus and I want to use this app in a near future to do more testing and labs withs microservices environments, stay tuned! 😎 
