# ![Snyk Logo](./images/logo-black.svg#gh-light-mode-only)![Snyk Logo - Dark Mode](./images/logo-white.svg#gh-dark-mode-only)      [![Deploy to Oracle Cloud][magic_button]][magic_snyk_stack]

Snyk: the platform developers choose to build cloud native applications securely, providing a range of developer-first security products.

## Summary

This quickstart allows you deploy Snyk Monitor on an existent OKE Cluster. Optionally allow you create a new OKE Kubernetes Cluster.

If you do not have any app to monitor and want to test, you can also deploy snyk's goof test app.

## Prerequisites

- An [Oracle Cloud](https://cloud.oracle.com/) Account.
- A [Snyk](https://snyk.co/udrgA) Business or Enterprise plan.
- If enable the Sysdig integration, you need the sysdig agent configured and running on the same cluster

## Deploying

You can deploy directly to you Oracle Cloud tenancy using this button: [![Deploy to Oracle Cloud][magic_button]][magic_snyk_stack] follow the wizard, include your Snyk integration Id and apply.

Or you can use Terraform scripts to apply. If you are using the Terraform (locally or via CloudShell), you need to copy the file `terraform.tfvars.example` to `terraform.tfvars` and populate the necessary variables.

## Using Snyk

Now that we have some workloads running on our OKE cluster and deployed Snyk, we can analyze these for insights into:

- Issues in open source libraries.
- Base image upgrade recommendations.
- Application misconfigurations.

As well as other features critical to running a secure environment available with [Snyk Container](https://snyk.io/product/container-vulnerability-management/).

### Scan Workloads

Login to [Snyk](https://snyk.co/udrgA) and navigate to the **Integrations** menu where you will click on the **Kubernetes** section. Select our cluster and desired namespace (in this case these are both named **goof**) then click the **Add selected workloads** button as shown below:

![Which Kubernetes workloads do you want to test?](https://3099555661-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MdwVZ6HOZriajCf5nXH%2Fuploads%2Fgit-blob-ba90cb05a02a58762ac54e864798d2fe0a47792e%2Fsnyk-k8s-integration-01.png?alt=media)

Detailed instructions on adding Kubernetes workloads are available in our [Documentation Pages](https://docs.snyk.io/products/snyk-container/image-scanning-library/kubernetes-workload-and-image-scanning/adding-kubernetes-workloads-for-security-scanning).

### Project Status

Once selected, you will be redirected to the main projects page where you will find a summary of the findings grouped by project as shown below:

![Project Status](https://3099555661-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MdwVZ6HOZriajCf5nXH%2Fuploads%2Fgit-blob-77446a0e12693258e6d84a83935f9654643264ef%2Fsnyk-k8s-integration-02.png?alt=media)

From this view, you can drill into each category and examine the findings. Let's start with misconfigurations of our cluster.

![Project Status detail](https://3099555661-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MdwVZ6HOZriajCf5nXH%2Fuploads%2Fgit-blob-aa5fc0f741e23682e6bd5efc1d5ecf3e3528ea8d%2Fsnyk-k8s-integration-03.png?alt=media)

Here we see that our application was deployed with various settings that were either not defined or incorrectly defined. For example, whether any containers in the workload have `container.securityContext.runAsNonRoot` set to `false`, or unset. These can be resolved by updating the Kubernetes manifest files for the deployment and can be resolved proactively with one of the many Snyk [Source Code Management (SCM) integrations](https://docs.snyk.io/features/integrations/git-repository-scm-integrations).

Next, let's examine our container image.

![Examine container image](https://3099555661-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MdwVZ6HOZriajCf5nXH%2Fuploads%2Fgit-blob-272049782428ed226680e28acda9b5637f233519%2Fsnyk-k8s-integration-04.png?alt=media)

Here we are provided with a base image upgrade recommendation that takes into account which image is compatible with our application and reduces the number of vulnerabilities to improve our security posture.

Finally, let's examine our open source dependencies and found vulnerabilities.

![open source dependencies and found vulnerabilities](https://3099555661-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MdwVZ6HOZriajCf5nXH%2Fuploads%2Fgit-blob-c2ec952ea219cac6c299d14f9f47e76b18da9fda%2Fsnyk-k8s-integration-05.png?alt=media)

In this view, we get detailed contextual data on found vulnerabilities along with [Snyk's Priority Score](https://snyk.io/blog/snyk-priority-score/) which helps to drastically simplify one of the biggest challenges in using open source securely—working out which vulnerabilities to tackle first.

## Questions

If you have an issue or a question, please [open an issue](https://github.com/oracle-quickstart/oke-snyk/issues/new).

[magic_button]: https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg
[magic_snyk_stack]: https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oracle-quickstart/oke-snyk/releases/latest/download/oke-snyk-stack.zip