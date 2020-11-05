# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Fixed
- Changed table column widths in `adoc-template-with-human-readable-lib-names.ftl` to be compatible with PDF generation 
    of `asciidoctor-maven-plugin` and `asciidoctorj-pdf`

## [1.1.0] - 2020-10-29
### Added
- A default list of approved licenses for Device Insight projects at 
    `src/main/resources/allowed-licenses-for-deviceinsight.txt`
- A template for adoc with a human readable library names at 
    `src/main/resources/com/deviceinsight/license/exporter/adoc-template-with-human-readable-lib-names.ftl`

### Changed
- Updated license-merges:
    - [LGPL-3.0](https://spdx.org/licenses/LGPL-3.0.html) is deprecated. [LGPL-3.0-only](https://spdx.org/licenses/LGPL-3.0-only.html) is used instead.
- Updated override-licenses:
    - [Janino](https://janino-compiler.github.io/janino/#license) uses the "New BSD License", which is confirmed as BSD-3-Clause
    - [LatencyUtils](https://github.com/LatencyUtils/LatencyUtils/blob/master/LICENSE) is under multiple licenses: Public Domain, CC0 and BSD-2-Clause
    - [Passay](http://www.passay.org)'s LGPL is LGPL-3.0 [[Reference](https://github.com/vt-middleware/passay/blob/master/LICENSE-lgpl)]

## [1.0.0] - 2020-07-16
### Added
- Initial version of the dependency-license-exporter

[Unreleased]: https://github.com/deviceinsight/dependency-license-exporter/compare/1.0.0...HEAD
[1.0.0]: https://github.com/deviceinsight/dependency-license-exporter/tree/1.0.0
