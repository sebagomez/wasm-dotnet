## WASM-DOTNET

Personal playground for wasm and .net

After seeing [this talk](https://www.youtube.com/watch?v=PIeYw7kJUIg) from [Steve Sanderson](https://twitter.com/stevensanderson) I thought I should give it a try and start playing around with WASM. 

We'll see where this takes me

After a huge amount of time and many trials and errors this is my current setup.

I have a local minikube ckuster in WSL2 with two nodes, one allows X64 apps and the other is only for WASM (via [kwasm](https://kwasm.sh/)). Both nodes are tainted.

I also have a simple [console app](./src/console/) that will try to find the nth fibonacci number and will at the end print the number and how long it took to find it.

```cs
	  static long Fibonacci(int n)
    {
        if (n <= 0)
        {
            return 0;
        }
        else if (n == 1)
        {
            return 1;
        }
        else
        {
            return Fibonacci(n - 1) + Fibonacci(n - 2);
        }
    }
```

I read somewhere (can't find the link) that this is a good example of a processor consumming algorithm to test performance. So in this case, this vary same code will be compiled for dotnet (x64) and wasm (using wasmtime)

I then created a couple of [docker files](./docker/) to have two images with the same app, again, one for dotnet and the other one for wasi. Those images are pushed to my personal repo at [Docker Hub](https://hub.docker.com/repository/docker/sebagomez/hello-wasm/general).

I finally created a couple of [Kubernetes jobs](https://kubernetes.io/docs/concepts/workloads/controllers/job/) that will pull execute the app with the same argument, in this case 40.

After applying those [Jobs](./k8s/) you can see that wou'll have two pods

```sh
k get pod
NAME                 READY   STATUS      RESTARTS   AGE
hello-dotnet-chvjk   0/1     Completed   0          15m
hello-wasm-zchcg     0/1     Completed   0          15m
```

Once both completed you can check the logs of each to compare the diference in execution time.

```sh
❯ k logs hello-dotnet-chvjk 
It took 00:00:00:674 to calculate the 40th Fibonacci number (102334155) in X64!

❯ k logs hello-wasm-zchcg 
It took 00:00:13:757 to calculate the 40th Fibonacci number (102334155) in Wasm!
```

So, you can see, x64 took less than a second while WASM took over 13 seconds to find the same number :(  

What does that mean? Not much really, I don't have a good environment with a fully WASI native node, so the next step is trying to reproduce this in an AKS clsuter to see if I get better results. I would expect, because of all the buzz about it, that wasm beats dotnet in time; but we'll see.

