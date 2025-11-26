#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Usage: ./publish.sh <version>"
    echo "Example: ./publish.sh 1.6.2.0"
    exit 1
fi

VERSION="$1"

echo "Publishing version $VERSION..."

# Update version in build.gradle
sed -i '' "s/^version = '.*'/version = '$VERSION'/" build.gradle

# Update version in pom.xml (only the project version on line 8)
sed -i '' "8s/<version>[^<]*<\/version>/<version>$VERSION<\/version>/" pom.xml

# Commit changes
git add build.gradle pom.xml
git commit -m "Bump version to $VERSION"
git push origin master

# Create release
gh api repos/diktamen/Java-WebSocket/releases -X POST \
    -f tag_name="$VERSION" \
    -f name="v$VERSION" \
    -f body="Release v$VERSION of the diktamen fork of Java-WebSocket."

echo "Done! Release $VERSION created."
echo "Monitor publish workflow: gh run list --repo diktamen/Java-WebSocket --limit 1"
