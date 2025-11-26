# Publishing Java-WebSocket

## Publishing a New Release

```bash
./publish.sh <version>
```

Example:
```bash
./publish.sh 1.6.2.0
```

This updates the version in `build.gradle` and `pom.xml`, commits, pushes, and creates a GitHub release which triggers the automated publish workflow.

## Using the Published Package

### Maven

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
  <version>1.6.1.1</version>
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
    implementation 'diktamen:java-websocket:1.6.1.1'
}
```

### Authentication

GitHub Packages requires authentication. Create a GitHub token with `read:packages` scope and configure:

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
