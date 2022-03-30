# Class diagrams

This app is split in packages to speed up developer iterations. There are packages for reusable 
infraestructure and for each screen –currently, just login and home.

## Packages

![packages](packages.png)

## Launch

![launch](launch.png)

main will
- reads the configuration from file "tumblr.plist"
- initializes the dependency container
- launch the application

The Scene delegate delegates to the OAuth2 client if it receives a call via custom protocol. 
Otherwise it starts the main coordinator.

The coordinator belongs to the MyTumblr package. You can read more about it there.
