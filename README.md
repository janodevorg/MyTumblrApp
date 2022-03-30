[![Swift](https://github.com/janodevorg/MyTumblrApp/actions/workflows/swift.yml/badge.svg)](https://github.com/janodevorg/MyTumblrApp/actions/workflows/swift.yml)

[Tumblr client application](https://janodevorg.github.io/MyTumblrApp/documentation/mytumblrapp/).

**_Work in progress_**


# Registration

How to register an application to access your Tumblr account.

## Overview

Tumblr is a microblog service.

The steps to configure this application to access a Tumblr account are:

1. Create an account
2. Register an application in https://www.tumblr.com/oauth/apps
3. Rename sources/main/tumblr.plist.sample to tumblr.plist and fill-in your own values.

### 1. Create an account

Create a new account or use single-sign on through Google.

### 2. Register an application

I wrote made-up data in the required fields. 

The critical value is callback and redirect URLs, it has to match the URI redirect of the 
Info.plist of your app. You can’t write just `oauthexample://callback`, it has to contain a domain,
but it doesn’t need to match a real domain.

| Field | Value |
|---|---|
| Application Name | `mytumblr` |
| Application Website | `https://jano.com.es` |
| Application Description | `Client app to test the Tumblr API` |
| Administrative contact email | `jano@jano.dev` |
| Default callback URL | `oauthexample://jano.dev/callback` |
| OAuth2 redirect URLs | `oauthexample://jano.dev/callback` |

### 3. Fill-in the tumblr.plist

After registration, you’ll see a page with your client id and secret. You need to copy the 
callback, client ID, and client Secret to the tumblr.plist file, with keys `callback`, `key`, 
and `secret`.
