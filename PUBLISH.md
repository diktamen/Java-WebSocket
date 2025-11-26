# Publishing Java-WebSocket

This document describes how to publish a new release of the diktamen fork of Java-WebSocket to GitHub Packages.

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
3. Create a new tag with the same version number
4. Set the release title
5. Click **"Publish release"**

The GitHub Actions workflow will automatically build and publish to GitHub Packages.

## Using the Published Package

### Maven

Add the GitHub Packages repository and dependency to your `pom.xml`:

```xml
<repositories>
  <repository>
    <id>github</id>
    <url>https://maven.pkg.github.com/diktamen/Java-WebSocket</url>
  </repository>
</repositories>

<dependency>
  <groupId>diktamen</groupId>
  <artifactId>java-websocket</artifactId>
  <version>1.6.1.0</version>
</dependency>
```

### Gradle

```groovy
repositories {
    maven {
        url = uri("https://maven.pkg.github.com/diktamen/Java-WebSocket")
        credentials {
            username = project.findProperty("gpr.user") ?: System.getenv("GITHUB_ACTOR")
            password = project.findProperty("gpr.token") ?: System.getenv("GITHUB_TOKEN")
        }
    }
}

dependencies {
    implementation 'diktamen:java-websocket:1.6.1.0'
}
```

### Authentication

GitHub Packages requires authentication. Configure your credentials:

**Maven** (`~/.m2/settings.xml`):
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

**Gradle** (`~/.gradle/gradle.properties`):
```properties
gpr.user=YOUR_GITHUB_USERNAME
gpr.token=YOUR_GITHUB_TOKEN
```
