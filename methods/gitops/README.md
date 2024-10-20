# #278

GitOps in a nutshell - Continuous Deployment for cloud native applications.

## Notes

I keep coming across references to GitOps, and usually the promise is to **finally** clear up the confusion about the topic.
At the end of the article there's usually a link to another document for more information about "What is GitOps Really?"

GitOps is officially described as

> a way of implementing Continuous Deployment for cloud native applications, coined by Weaveworks in 2017

What's not clear:

* is it just a method/conceptual approach?
* or is it a fully baked solution that is ready to use?

I think my confusion stems from the fact that it tries to be both, with a lot of caveats.
As far as I understand:

* yes, it is a philosophy and conceptual approach. Essentially:
    * the target environment is formally described and versioned alongside code and build artifacts
    * the environment description is used to automate deployment (including rollbacks)
    * and yes, at a conceptual level, this doesn't dictate or require any specific tools or standards for how this can be achieved
* but it also describes a specific approach for how this can be realised. Essentially:
    * GitHub for versioning
    * GitHub Workflows with Actions for implementing the process
    * [Kubernetes](https://kubernetes.io/) for managing the infrastructure
    * [Flux](https://fluxcd.io/) for orchestrating Kubernetes according to the environment description

The [GitOps](https://www.gitops.tech/) site and associated
[ebook](https://leanpub.com/gitops)
provide an introduction to the topic and also a practical example of
setting up a pull-based GitOps workflow with the Flux Operator on Kubernetes.

* [Example Application Repository](https://github.com/gitops-tech/example-application)
* [Example Environment Repository](https://github.com/gitops-tech/example-environment)

## Credits and References

* [GitOps](https://www.gitops.tech/)
* [Flux](https://fluxcd.io/)
* [Kubernetes](https://kubernetes.io/)
* [Example Application Repository](https://github.com/gitops-tech/example-application)
* [Example Environment Repository](https://github.com/gitops-tech/example-environment)
* [Full Stack Journey 067: What The Heck Is GitOps?](https://packetpushers.net/podcasts/full-stack-journey/full-stack-journey-067-what-the-heck-is-gitops/) - packetpushers podcast
* [Full Stack Journey 079: Infrastructure Management With GitOps & Flux With Frank Wiles](https://packetpushers.net/podcasts/full-stack-journey/full-stack-journey-079-infrastructure-management-with-gitops-flux-with-frank-wiles/) - packetpushers podcast
