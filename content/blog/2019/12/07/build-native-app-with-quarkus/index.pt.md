---
title: 'Construindo uma aplicação nativa com Quarkus'
subtitle: 'Uma aplicação simples de Echo usando resteasy e swagger com quarkus'
summary: Uma aplicação simples de Echo usando resteasy e swagger com quarkus
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
  caption: 'Créditos: [**Atom**](https://onextrapixel.com/best-atom-packages-web-developers/)'
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
<h2>Índice</h2>
</header>
- [1. Visão Geral](#visao-geral)
- [2. Aplicativo Echo](#echo-app)
- [3. Geração do Projeto](#geracao-do-projeto)
- [4. Swagger](#swagger)
- [5. DockerHub](#dockerhub)
- [6. Conclusão](#conclusao)
</div>
</aside>
<!--endtoc-->

## 1. Overview {#overview}

Eu quero falar de 88Microserviços**, mas então eu percebi que na verdade eu não muito material publicado que eu possa usar pra isso, como **um microserviço**.

Por conta disso eu decidi criar um pequeno microserviço do zero, o qual eu possa reusar em futuros artigos pra fazer mais coisas legais 😝

Pra isso eu escolhi um framework muito falado hoje em dia, que é bem interessante: [Quarkus](https://quarkus.io/).

A idéia é criar um serviço simples de echo: eu mando um texto e a API responde o mesmo texto em PLAINTEXT. Além disso eu adicionarei um parametro de time pra decidir em quanto tempo eu quero que essa resposta seja retornada.

## 2. Aplicativo Echo {#echo-app} 

Um endpoint REST simples que retorna o mesmo texto que eu enviar como parametro. Também deve ser possível pedir um tempo de espera em milisegundos pra API responder.

Você pode encontrar o código fonte completo deste exemplo no meu [GitHub](https://github.com/jjbeto/echo), ou você também pode:

- Baixar a imagem diretamente do [DockerHub](https://hub.docker.com/r/jjbeto/echo)

## 3. Geração do Projeto {#geracao-do-projeto}

Eu segui as etapas descritas na documentação do [Quarkus](https://quarkus.io/guides/openapi-swaggerui):

1. Criar o projeto base:

```bash
mvn io.quarkus:quarkus-maven-plugin:1.0.1.Final:create \
    -DprojectGroupId=com.jjbeto \
    -DprojectArtifactId=echo \
    -DclassName=com.jjbeto.echo.EchoResource \
    -Dpath=/echo \
    -Dextensions=resteasy-jsonb
```

2. Removi .mvn do git: adicionei `.mvn` no `.gitignore`

3. Criar a lógica da aplicação: retornar o texto parametrizado como PLAINTEXT e aceitar um query parameter como tempo de espera antes da API retornar a resposta.

    - Mudar o path root pra ser da própria aplicação;
    - Retornar a mensagem no path parameter de volta para o cliente;
    - Adicionar um tempo de espera de acordo com o query parameter;

## 4. Swagger {#swagger}

Vamos tornar essa API mais amigável pra ser consumida por outras aplicaçōes, adicionando Swagger e colocando algumas descriçōes, explicando pra que serve cada parâmetro. Com Quarkus isso é bem facil e pode ser encontrado como fazer diretamente na [documentação](https://quarkus.io/guides/openapi-swaggerui).

Primeiramente precisamos adicionar o Swagger ao projeto, executando o comando a seguir diretamente na raiz do projeto:

```bash
./mvnw quarkus:add-extension -Dextensions="openapi"
```

Mas eu não gosto do endpoint gerado automaticamente `/openapi` 😒, então eu vou mudar para `/swagger`. Pra isso basta mudar uma propriedade em `application.properties`:

```properties
quarkus.smallrye-openapi.path=/swagger
```

O endpoint `/swagger` vai fornecer um arquivo Yaml descrevendo a API.

Eu também quero ativar o SwaggerUI:

```properties
quarkus.swagger-ui.always-include=true
```

O endpoint padrão para o SwaggerUI é [http://localhost:8080/swagger-ui](http://localhost:8080/swagger-ui).

Muito bom! Agora vamos seguir em frente e adicionar algumas descriçōes para que usuários da API saibam como utiliza-la. De acordo com a [especificação](https://swagger.io/specification/) nós precisamos usar um arquivo `openapi.yml` para adicionar dados customizados:

1. Acesse `http://localhost:8080/swagger` para baixar o arquivo `openapi.yml` atualizado
2. Salve `openapi.yml` no diretório `./src/main/resources/META-INF`
3. Adicione algumas descriçōes e informaçōes sobre a API

Agora você pode verificar novamente o endereço local [http://localhost:8080/swagger-ui](http://localhost:8080/swagger-ui) e verifique o resultado 😃

## 5. DockerHub {#dockerhub}

Eu quero que seja possível que qualquer um possa baixar a imagem diretamente do DockerHub.

### Construindo uma Imagem Nativa

Quarkus permite a criação de um app completamente nativo, onde uma JVM não é necessária. Isso é incrivel principalmente quando se trata de aplicaçōes simples como o **Echo**, por que a aplicação fica muito rápida e a imagem para execução muito pequena!

Para construir a imagem nativa nós precisamos de alguns pre-requisitos conforme mencionado na [documentação do Quarkus](https://quarkus.io/guides/building-native-image), por favor siga estes passos antes de continuar.

Notas: fique atento da versão do GraalVM, se a que você esta instalando é compatível com a versão atual do Quarkus. O Quarkus está sempre em evolução e fica o mais próximo possível das últimas atualizaçōes do GraalVM, mas é preciso verificar se a versão atual é compatível: no momento que estou escrevendo este artigo o GraalVM está na versão 19.3.0.r11 enquanto o Quarkus é compatível apenas com **GraalVM 19.2.1**.

Depois de instalar o GraalVM (eu usei [sdkman](https://sdkman.io/)), Docker (ou podman) e as suas dependencias, você pode construir uma imagem nativa com o comando:

```bash
./mvnw package -Pnative -Dquarkus.native.container-build=true
```

De acordo com o **Quarkus** a construção de uma imagem é muito simples: 

![Quarkus Build Process](https://quarkus.io/guides/images/native-executable-process.png)

TL;TR é exatamente como construir um executável Jar com todas as suas dependencias (fat jar), mas a execução para construir uma imagem nativa demora mais tempo pra executar e custa mais recursos da máquina.

#### Notas importantes sobre o processo de construção

Ao construir a imagem usando Docker no meu Mac, eu recebi este erro:

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

Eu encontrei uma issue no [GitHub do Quarkus](https://github.com/quarkusio/quarkus/issues/1140) relativo a esse erro e, quando mudei a memória do meu Docker para 3GB (ao invés dos 2GB padrão), o build funcionou:

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

#### Preparar a Imagem

Para criar a imagem localmente podemos executar o seguinte comando:

```bash
docker build -f src/main/docker/Dockerfile.native -t jjbeto/echo .
```

O resultado:

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

Se você listar as imagens locais:

```bash
docker images
REPOSITORY       TAG                 IMAGE ID            CREATED             SIZE
jjbeto/echo      latest              33592d7cd99d        12 seconds ago      142MB
```

Agora podemos finalmente executar nossa imagem:

```bash
docker run -i --rm -p 8080:8080 jjbeto/echo
```

E o resultado:

```bash
2019-12-07 14:48:13,719 INFO  [io.quarkus] (main) echo 1.0-SNAPSHOT (running on Quarkus 1.0.1.Final) started in 0.012s. Listening on: http://0.0.0.0:8080
2019-12-07 14:48:13,719 INFO  [io.quarkus] (main) Profile prod activated. 
2019-12-07 14:48:13,719 INFO  [io.quarkus] (main) Installed features: [cdi, resteasy, resteasy-jsonb, smallrye-openapi, swagger-ui]
```

Sensacional! E se acessarmos o localhost:

{{< figure src="localhost-8080.png" title="Localhost executando na porta 8080" >}}

Mas... A imagem ainda é muito grande! 142MB não é um bom tamanho legal pra um serviço tão pequeno, certo?

Eu mudei o arquivo `.src/main/docker/Dockerfile.native` para usar o mínimo necessário de arquivos da imagem `debian:10-slim`, seguindo [esse conselho](https://github.com/quarkusio/quarkus/issues/326): 

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

E agora a minha imagem tem um tamanho mais interessante: 44.5MB

```bash
docker images
REPOSITORY        TAG                 IMAGE ID            CREATED             SIZE
jjbeto/echo       latest              3d7de934bcd4        29 seconds ago      44.5MB
```

Mas o resultado final no DockerHub é diferente:

{{< figure src="dockerhub.png" title="Imagem no DockerHub" >}}

15MB?? Agora sim!! 😎

Você sabe como torná-la ainda menor? Por favor me manda uma mensagem! 📫

#### Como Publicar no DockerHub?

Para publicar a imagem no DockerHub é muito simples:

1. Login com o comando `docker login` e usar seu usuário/senha
2. Enviar sua imagem local para o repositório remoto com o comando `docker push <image_name>`, no meu caso `docker push jjbeto/echo`
3. Vá até o [DockerHub](https://hub.docker.com/r/jjbeto/echo) e verifique o resultado 🎉

## 6. Conclusão {#conclusao}

Quarkus é uma ferramenta incrível e renova mais uma vez o poder do Java no mundo atual, na minha opinião. É fácio de usar, já possui uma grande lista de ferramentas que podem ser usadas em conjunto, como Hibernate, Vert.x e MicroProfile.

Mas por favor não se engane, Quarkus não é pra todo mundo e nem pra todo projeto! Como é construido usando GraalVM, não é possível usar qualquer lib que você encontrar, ou você pode encontrar problemas como reflections por exemplo.

Se você puder usar as libs padrões do Quarkus, com certeza ele é um framework pra se levar em consideração no seu projeto.

Sobre o Echo App, Quarkus foi uma boa escolha! O app foi gerado já pensando um pouco mais na frente, quando eu for fazer alguns testes com ambientes de microserviços, fiquem ligados! 😎
