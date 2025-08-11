
2025-08-10 22:32

Status: #adult

Tags: [[Github]] [[Domain]] [[Website]]

# Setting up a Custom Domain for Github Pages


Step 1: Prepare Your GitHub Repository

First, make sure your GitHub repository is set to public. Only public repositories can be used to host GitHub Pages sites. Once public, navigate to the Pages tab within your repository’s Settings.

Here, you’ll configure the source for your website deployment. Opt for GitHub Actions as your deployment method. GitHub Actions is a powerful automation tool that can build and deploy your static site every time you push updates.

GitHub provides a wide range of predefined workflows for various technologies, including Docker containers, Jekyll sites, AWS deployments, and more. You’ll need to set up a YAML workflow file under .github/workflows/ that matches your project’s build requirements. Once configured and pushed, GitHub Actions will automatically build your site and host it at a default URL structured as:

```
https://<GitHubUsername>.github.io/<RepositoryName>/
```

Step 2: Purchase and Configure a Custom Domain

While the default GitHub Pages URL works fine, using a custom domain gives your site a professional appearance and easier access. You can purchase domains from registrars like cheapdomains.com or cloudflare.com.

After acquiring your domain, the next step is to configure its DNS settings to point traffic to GitHub Pages servers. GitHub Pages uses specific IP addresses to serve your site reliably, which you must include in your domain’s DNS A records: https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site

```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

These IP addresses ensure traffic routes correctly to GitHub’s global CDN network hosting your site.

Additionally, to support the custom domain within your repository, create a CNAME file in your project’s root directory containing your domain name (for example, www.yourdomain.com). This file tells GitHub Pages to associate your custom domain with the site.

```
www
```


To test the website wait 30 minutes and use service such as https://dnschecker.org/ to confirm uptime/availability. 

By following these steps, you’ll have a professional, custom-branded static site deployed and hosted on GitHub Pages—perfect for portfolios, documentation, blogs, or project showcases.


## References

https://www.youtube.com/watch?v=e5AwNU3Y2es

[[Setting up Jekyll for Github Pages]]
[[Set Up a Github Pages for Obsidian using Quartz]]
