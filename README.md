# dependency-license-exporter

This repo is a small maven project which generates a `jar` to place config files on the classpath
when generating dependency license information using [License Maven Plugin](https://www.mojohaus.org/license-maven-plugin/).
These config files allows for a generated license list that matches the company requirements.

## Quick Start

Add a maven profile to your `pom.xml`:

```xml
<project>
    <!-- ... -->
    <properties>
        <!-- licenses -->
        <license-maven-plugin.version>2.0.0</license-maven-plugin.version>
        <dependency-license-exporter.version>0.1.0-SNAPSHOT</dependency-license-exporter.version>
    </properties>

    <!-- ... -->
    <profiles>
        <profile>
            <id>create-license-list</id>
            <build>
                <plugins>
                    <plugin>
                        <groupId>org.codehaus.mojo</groupId>
                        <artifactId>license-maven-plugin</artifactId>
                        <version>${license-maven-plugin.version}</version>
                        <dependencies>
                            <dependency>
                                <groupId>com.deviceinsight</groupId>
                                <artifactId>dependency-license-exporter</artifactId>
                                <version>${dependency-license-exporter.version}</version>
                            </dependency>
                        </dependencies>
                        <configuration>
                            <useMissingFile>true</useMissingFile>
                            <licenseMergesUrl>classpath:license-merges.txt</licenseMergesUrl>
                            <overrideUrl>classpath:override-licenses.txt</overrideUrl>
                            <includedLicenses>classpath:allowed-licenses-for-deviceinsight.txt</includedLicenses>
                            <useMissingFile>false</useMissingFile>
                            <excludeTransitiveDependencies>true</excludeTransitiveDependencies>
                            <includeTransitiveDependencies>false</includeTransitiveDependencies>
                            <excludedScopes>test,provided</excludedScopes>
                            <excludedGroups>^com\.deviceinsight|^net\.centersight</excludedGroups>
                            <thirdPartyFilename>dependencies-license.adoc</thirdPartyFilename>
                            <fileTemplate>/com/deviceinsight/license/exporter/adoc-template.ftl</fileTemplate>
                            <outputDirectory>${project.basedir}</outputDirectory>
                        </configuration>
                        <executions>
                            <execution>
                                <id>create-license-list</id>
                                <goals>
                                    <!-- choose one of these goals for your project -->
                                    <goal>add-third-party</goal>
                                    <goal>aggregate-add-third-party</goal>
                                </goals>
                                <phase>generate-resources</phase>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>
        </profile>
    </profiles>
</project>
```

Now run the following command and a file `dependencies-license.adoc` should be generated in the root folder of the project:
```bash
mvn clean generate-resources -Pcreate-license-list
```
Or invoke the goal directly:
```bash
mvn license:add-third-party
mvn license:aggregate-add-third-party
```

## Configuration Guide


### Overriding Default Configuration Files

Each project can also override the files included in this plugin with their own, e.g.:
```xml
    <configuration>
        <!-- Use custom allowed licenses list -->
        <includedLicenses>file:/${maven.multiModuleProjectDirectory}/dependencies-license-allowed.txt</includedLicenses>
        <!-- Use custom template -->
        <fileTemplate>${project.basedir}/dependencies-license-template.ftl</fileTemplate>
        <!-- ... -->
    </configuration>
```

### Overriding Found Licenses

If [License Maven Plugin](https://www.mojohaus.org/license-maven-plugin/) determines a license for a dependency but the
license is incorrect or not specific enough, we can override it:

In this repo we maintain file with license overrides (`src/main/resources/override-licenses.txt`) where license information can be added.
this file is loaded via `overrideUrl` configuration in the profile above.

#### File Format

```text
${mavenGroupId}--${mavenArtifactId}--${version}=${license}
```

NOTE: `${license}` should be the `spdx identifier` of the license (see: https://spdx.org/licenses/).

### Missing Licenses

If [License Maven Plugin](https://www.mojohaus.org/license-maven-plugin/) was unable to determine the license for a dependency
the license can manually be added. Missing licenses can be added in two ways:

- Recommended way: Define the license in license overrides, see above
- If you do not want to define the license in that central place for whatever reason, it is possible to define
  it in the local project.
  * Remove the configuration `<useMissingFile>true</useMissingFile>` or define it as `false`
  * The build will generate a file `src/license/THIRD-PARTY.properties`, see: [missingFile configuration](https://www.mojohaus.org/license-maven-plugin/add-third-party-mojo.html#missingFile)
  * Define the license in that file \
   The file format is the same as in the license overrides
  * Note: The `override-licenses.txt` will override that definition


### Merging Licenses

Dependencies might declare the name of the same license in different ways e.g. (`Apache 2`, `Apache 2.0`, `...`) in order
to consolidate the used licenses different names can be merged into one using the file `src/main/resources/license-merges.txt`
which is loaded via `licenseMergesUrl` configuration in the profile above.

#### File Format

```text
${spdx identifier}|${license spelling A}|${license spelling B}|${license spelling C}
```

In order to have a consistent naming of the licenses the first entry in a row should be the `spdx identifier` of the
license (see: https://spdx.org/licenses/).

Whenever a new `spdx identifier` is added, make sure to add it to the output templates as well, e.g.
`src/main/resources/com/deviceinsight/license/exporter/adoc-template.ftl`.
This way we can directly generate a link to the license description.

### Multi module project

There are two different goals: `add-third-party` and `aggregate-add-third-party`.
With `add-third-party` the dependency file is created for each module.
If only one dependency file in a multi module project should be generated, the `aggregate-add-third-party` goal can be used.

### Allowed Licenses
Projects can be configured to fail at build time when containing a library whose license is not allowed:

```xml
    <configuration>
        <failOnBlacklist>true</failOnBlacklist>
        <includedLicenses>classpath:allowed-licenses.txt</includedLicenses>
    </configuration>
```

### Built-in Templates for Generated License List
This plugin provides two built-in asciidoc templates for the generated license files.
`adoc-template.ftl` lists the libraries with groupId:artifactId, version, URL and the SPDX link to the license.
`adoc-template-four-columns.ftl` lists the libraries with human readable name - linked to the library's homepage, 
groupId:artifactId, version,  and the SPDX link to the license.

```xml
    <configuration>
        <fileTemplate>/com/deviceinsight/license/exporter/adoc-template-four-columns.ftl</fileTemplate>
        <!-- ... -->
    </configuration>
```

## Releasing

Creating a new release involves the following steps:

* `mvn gitflow:release-start gitflow:release-finish`
* `git push origin master`
* `git push --tags`
* `git push origin develop`

In order to deploy the release to Maven Central, you need to create an account at https://issues.sonatype.org and
configure your account in `~/.m2/settings.xml`:

```xml
<settings>
  <servers>
    <server>
      <id>ossrh</id>
      <username>your-jira-id</username>
      <password>your-jira-pwd</password>
    </server>
  </servers>
</settings>
```

The account also needs access to the project on Maven Central. This can be requested by another project member.

Then check out the release you want to deploy (`git checkout x.y.z`) and run `mvn deploy -Prelease`.
