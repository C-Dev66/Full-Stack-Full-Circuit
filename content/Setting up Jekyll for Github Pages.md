
2025-08-08 23:17

Status: #adult 

Tags: [[Jekyll]] [[Github]] [[Website]] [[Domain]] [[Homebrew]]

# Setting up Jekyll for Github Pages

Jekyll is a popular static site generator known for its simplicity and seamless integration with GitHub Pages. Unlike traditional Content Management Systems (CMS) platforms, Jekyll doesn’t require databases or comment moderation, making it ideal for lightweight, fast-loading websites. For my first Jekyll deployment, my goal is to create a main website using my primary domain and set up a subdomain dedicated to hosting my notes, CV, projects, and links to my social profiles.

Preparing Your System: Ruby and Development Tools

Jekyll is built with Ruby, so having the right Ruby environment is essential. On macOS, the easiest way to manage this setup is through Homebrew, a popular package manager that simplifies installing developer tools.

The process begins by installing chruby, a lightweight Ruby version manager, and ruby-install to handle Ruby installations. This allows you to manage multiple Ruby versions on your machine, which is crucial because Jekyll and its dependencies often require specific Ruby versions. Configuring your shell to use chruby ensures your terminal sessions always run the correct Ruby version.

```
"Install chruby, a lightweight Ruby version manager"
brew install chruby ruby-install

"Install the latest versin of Ruby"
ruby-install ruby 3.4.1

"Configure your shell to automatically use chruby"
echo "source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh" >> ~/.zshrc
echo "source $(brew --prefix)/opt/chruby/share/chruby/auto.sh" >> ~/.zshrc
echo "chruby ruby-3.4.1" >> ~/.zshrc # run 'chruby' to see actual version

"Quit and relaunch Terminal, then check that everything is working"
ruby -v

"After installing Ruby with chruby, install the latest Jekyll gem"
gem install jekyll
```

In addition, installing Apple’s Xcode Command Line Tools provides the necessary compilers and system libraries to build Ruby gems that include native extensions, such as those used by Jekyll.

Troubleshooting Ruby and Gem Installation

During my setup, I encountered several challenges, particularly with installing the Jekyll gem. These included:
	•	Conflicts between Ruby versions on my system.
	•	Missing C++ compilers that are necessary for building native gem extensions.
	•	Issues arising from outdated or mismatched Ruby versions, which caused local builds to fail.

To resolve these, I reinstalled the Xcode Command Line Tools and reinstalled Ruby using chruby. This ensured the development environment was consistent and compatible with Jekyll.

Choosing the Right Jekyll Theme

Initially, I planned to use the jekyll-linktree theme: https://github.com/topics/jekyll-linktree  to create a clean link hub similar to the popular Linktree service. However, the theme’s gem dependencies clashed with my Ruby environment, causing deployment failures on my local machine. This was compounded by GitHub Pages’ limited support for certain Ruby versions.

To overcome this, I shifted to using GitHub’s template repository method for Jekyll sites, which streamlines setup but still requires compatible themes.

Exploring the wide variety of Jekyll themes available on GitHub (https://github.com/search?q=jekyll+theme&type=repositories), I discovered the Moonrise theme by Tolga Tatli. This theme is actively maintained and supports modern Ruby and Jekyll versions: https://github.com/TolgaTatli/Moonrise.


Setting Up the Moonrise Theme

I forked the Moonrise repository and cloned it locally to customize it for my needs. Configuring GitHub Actions allowed me to automate builds using the latest Ruby environment, ensuring compatibility with GitHub Pages.

Locally, I used Bundler to install the required gems and serve the site. This workflow helped me verify changes and troubleshoot any dependency issues before pushing updates to GitHub.


```
"Commands used"
bundle install

bundle exec jekyll serve

"to exit the local host Press Ctrl+C"
```

Final Outcome

After a few hours of troubleshooting and learning the nuances of Ruby environment management, my main Jekyll website is now live and fully functional. The site will serve as a professional hub linking to my projects, notes, CV, and social connections, all built on a clean, static framework that is easy to maintain and fast to load

## References

https://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/

https://github.com/eventmachine/eventmachine/issues/990

[[Github Token Expired - Fix]]
[[Set Up a Github Pages for Obsidian using Quartz]]
[[Setting up a Custom Domain for Github Pages]]



