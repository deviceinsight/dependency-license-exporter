<#-- spdxIdentifiers should contain all identifiers that are merged in license-merges.txt -->
<#assign spdxIdentifiers = ['Apache-2.0', 'Apache-1.1', 'BSD-2-Clause', 'BSD-3-Clause', 'MIT', 'EPL-1.0', 'EPL-2.0',
'CDDL-1.0', 'CDDL-1.1', 'CC0-1.0', 'LGPL-2.1', 'LGPL-2.1+', 'MPL-1.1', 'GPL-2.0-with-classpath-exception',
'CC-BY-SA-3.0', 'GPL-3.0', 'LGPL-3.0']>

<#assign spdxBaseUrl = 'https://spdx.org/licenses/'>

<#function spdxLink license>
    <#assign result = spdxBaseUrl + license + '.html[' + license + ']' />
    <#return result>
</#function>

<#function licenseFormat licenses>
    <#assign result = ""/>
    <#list licenses as license>
        <#if result?length &gt; 0>
            <#assign result = result + ", "/>
        </#if>
        <#if spdxIdentifiers?seq_index_of(license) &gt; -1>
            <#assign result = result + spdxLink(license) />
        <#else>
            <#assign result = result + license />
        </#if>
    </#list>
    <#return result>
</#function>
.List of dependencies and license
[cols="25%,40%,2*",options="header"]
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