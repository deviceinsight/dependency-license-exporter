<#include "template-base.ftl">

.List of dependencies and license
[options="header"]
|===
| Dependency | version | source url | license

<#if dependencyMap?size == 0>
| project has no dependencies |   |  |  |
<#else>
    <#list dependencyMap as e>
        <#assign project = e.getKey()/>
        <#assign licenses = e.getValue()/>
| ${project.groupId}:${project.artifactId} | ${project.version} | ${(project.url!"no url defined")} | ${licenseFormat(licenses)}
    </#list>
</#if>
|===