# Publishing Java-WebSocket

This document describes how to publish a new release of the diktamen fork of Java-WebSocket to GitHub Packages.

## Prerequisites

- Push access to the repository
- Ability to create releases on GitHub

## Steps to Publish

### 1. Update the version number

The version number must be updated in **two places**:

- `build.gradle` (line 13):
  ```groovy
  version = 'X.Y.Z'
  ```

- `pom.xml` (line 8):
  ```xml
  <version>X.Y.Z</version>
  ```

### 2. Commit and push the version changes

```bash
git add build.gradle pom.xml
git commit -m "Bump version to X.Y.Z"
git push origin master
```

### 3. Create a GitHub Release

1. Go to [Releases](https://github.com/diktamen/Java-WebSocket/releases)
2. Click **"Draft a new release"**
3. Create a new tag with the same version number (e.g., `1.6.1-0`)
4. Set the release title (e.g., `v1.6.1-0`)
5. Add release notes describing the changes
6. Click **"Publish release"**

### 4. Automated Publishing

When you publish the release, the GitHub Actions workflow (`.github/workflows/gradle-publish.yml`) will automatically:

1. Build the project
2. Create sources and javadoc JARs
3. Publish all artifacts to GitHub Packages

You can monitor the workflow progress in the [Actions tab](https://github.com/diktamen/Java-WebSocket/actions).

## Using the Published Package

### Maven

Add the GitHub Packages repository to your `pom.xml`:

```xml
<repositories>
  <repository>
    <id>github</id>
    <url>https://maven.pkg.github.com/diktamen/Java-WebSocket</url>
  </repository>
</repositories>
```

Add the dependency:

```xml
<dependency>
  <groupId>diktamen</groupId>
  <artifactId>Java-WebSocket</artifactId>
  <version>1.6.1-0</version>
</dependency>
```

### Gradle

Add the GitHub Packages repository to your `build.gradle`:

```groovy
repositories {
    maven {
        url = uri("https://maven.pkg.github.com/diktamen/Java-WebSocket")
        credentials {
            username = System.getenv("GITHUB_ACTOR") ?: project.findProperty("gpr.user")
            password = System.getenv("GITHUB_TOKEN") ?: project.findProperty("gpr.token")
        }
    }
}
```

Add the dependency:

```groovy
implementation 'diktamen:Java-WebSocket:1.6.1-0'
```

### Authentication

GitHub Packages requires authentication even for public packages. You'll need to:

1. Create a GitHub Personal Access Token (PAT) with `read:packages` scope
2. Configure it in your `~/.m2/settings.xml` (Maven) or `~/.gradle/gradle.properties` (Gradle)

#### Maven (`~/.m2/settings.xml`):

```xml
<settings>
  <servers>
    <server>
      <id>github</id>
      <username>YOUR_GITHUB_USERNAME</username>
      <password>YOUR_GITHUB_TOKEN</password>
    </server>
  </servers>
</settings>
```

#### Gradle (`~/.gradle/gradle.properties`):

```properties
gpr.user=YOUR_GITHUB_USERNAME
gpr.token=YOUR_GITHUB_TOKEN
```
