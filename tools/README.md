### Mason

The project uses [mason](https://pub.dev/packages/mason) to generate code based on templates.
To install [mason](https://pub.dev/packages/mason) you need to run the command:

```sh
# Install from pub.dev
dart pub global activate mason_cli

# Or

# Install from  homebrew
brew tap felangel/mason
brew install mason
```

The project uses 1 templates - [feature](tools/bricks/feature)
In order for templates to be used, they need to be obtained from [mason.yaml](mason.yaml). Run the following command:

```sh
mason get
```

To generate code based on a template, you need to run the following command:

```sh
mason make TEMPLATE_NAME # insert the template 'feature' instead of TEMPLATE_NAME
```
