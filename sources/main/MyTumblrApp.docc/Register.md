# Register your client

Tumblr is a microblog service. Meaning, a blog with the size of an Instagram post.

To access the Tumblr API you need to register with OAuth2. However, in this open source project 
I can’t give you my registration data because then you would be in control of my account. Instead,
you’ll have to register your own client. This page explains how.

If you are not up to the task, that’s fine. This is not a commercial client.

## Overview

The steps to configure this application to access a Tumblr account are:

1. Create an account in Tumblr
2. Register an application in https://www.tumblr.com/oauth/apps
3. Fill-in the tumblr.plist file with data from your application.

### 1. Create an account

Create a new account on Tumblr or use single-sign on through Google.

### 2. Register an application

You can write random data in most required fields. The critical value is callback and redirect 
URLs, it has to match the URI redirect of the Info.plist of your app. You can’t write just 
`oauthexample://callback`, it has to contain a domain, but it doesn’t need to match a real domain.

| Field | Value |
|---|---|
| Application Name | `mytumblr` |
| Application Website | `https://jano.com.es` |
| Application Description | `Client app to test the Tumblr API` |
| Administrative contact email | `jano@jano.dev` |
| Default callback URL | `oauthexample://jano.dev/callback` |
| OAuth2 redirect URLs | `oauthexample://jano.dev/callback` |

### 3. Fill-in the tumblr.plist

After registration, you’ll see a page with your **client id** and **secret**. You need to copy 
the callback, client ID, and client Secret to the tumblr.plist file, with keys `callback`, `key`, 
and `secret`.
