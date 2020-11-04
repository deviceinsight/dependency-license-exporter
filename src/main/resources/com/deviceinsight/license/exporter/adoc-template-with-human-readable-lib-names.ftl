<#include "template-base.ftl">

.List of dependencies and license
[cols="25,40,15,10",options="header"]
|===
| Library | Maven Artifact ID | Version | License

<#if dependencyMap?size == 0>
    | project has no dependencies |   |  |
<#else>
    <#list dependencyMap as e>
        <#assign project = e.getKey()/>
        <#assign licenses = e.getValue()/>
| ${(project.url!"no url defined")}[${(project.name!"Unnamed")}] | ${project.groupId}:${project.artifactId} | ${project.version} | ${licenseFormat(licenses)}
    </#list>
</#if>
|===