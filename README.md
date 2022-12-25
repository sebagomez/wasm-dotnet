## WASM-DOTNET

Personal playground for wasm and .net

After seeing [this talk](https://www.youtube.com/watch?v=PIeYw7kJUIg) from [Steve Sanderson](https://twitter.com/stevensanderson) I thought I should give it a try and start playing around with WASM. 

The ultimate goal would be to replace one of my current public docker images, most likely [AzureStorageExplorer](https://github.com/sebagomez/azurestorageexplorer), with a WASM module published somewhere on a public "wasm registry" (if that's even a thing)

The first thing I want to do accomplish is just having a minimal Hello World console app.  

![](./res/console.png)

> I used wasmer with the console app but it's not as mature as wasmtime, so I'm using wasmtime from now on._

![](./res/web.png)

Then I'd like to create a library as a wasm module, and reference that module (already compiled) from any WASM app. Ideally, I could also reference any WASMI compatible module, it could have been written in Rust, C/C++, Go, or whatever.  

> So I wrote it in C# and I was glad to know I do NOT need to compile it for WASM myself. Which means every NuGet package out there can still be referenced and used in a WASM application. Which makes sense if you think about it, you don't want to recompile every simple existing package into WASM. You just use what you need and compile your application to WASM.

Next step would be to create a web app, something that listens on port 80 and replies back.

> The [web](./src/web/) app does that, and it also uses the [lib](./src/lib) previously created. I also created an account at [WebAssemblyHub](https://webassemblyhub.io/user/sebagomez) to have a registry for my wasm "images". And after downloading [wasme](https://docs.solo.io/web-assembly-hub/latest/installation/) I used the following commands to build and publish my image.

```bash
❯ wasme build precompiled src/web/bin/Debug/net7.0/web.wasm -t webassemblyhub.io/sebagomez/webapi-hello -c src/runtime-config.json
INFO[0000] adding image to cache...                      filter file=src/web/bin/Debug/net7.0/web.wasm tag=webassemblyhub.io/sebagomez/webapi-hello
INFO[0000] tagged image                                  digest="sha256:e2113b8571cde8ff004760131e5881476427f9079069401dfc6b0c7c694afcfc" image="webassemblyhub.io/sebagomez/webapi-hello:latest"
```

```bash
❯ wasme push webassemblyhub.io/sebagomez/webapi-hello
INFO[0000] Pushing image webassemblyhub.io/sebagomez/webapi-hello 
INFO[0023] Pushed webassemblyhub.io/sebagomez/webapi-hello:latest 
INFO[0023] Digest: sha256:c2c6bb62ab74d97a67bc37786397e891319d889f61dce724c721a1e3adbb3611 
```

So now, there's supposed to be a wasm module at webassemblyhub.io/sebagomez/webapi-hello

Let's see how can I now create a K8s cluster with a wasi runtime where I can execute a pod with that image.


We'll see where this takes me

_Follow the instructions on the [.NET WASI SDK](https://github.com/dotnet/dotnet-wasi-sdk) repo if you want to build it yourself. So far I have not changed anything_
