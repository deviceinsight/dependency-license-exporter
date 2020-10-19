<#-- spdxIdentifiers should contain all identifiers that are merged in license-merges.txt -->
<#assign spdxIdentifiers = ['Apache Software Licenses', 'Apache-1.1', 'Apache-2.0', 'BSD style', 'BSD-2-Clause',
    'BSD-3-Clause', 'CC-BY-SA-3.0', 'CC0-1.0', 'CDDL-1.0', 'CDDL-1.1', 'EDL-1.0', 'EPL-1.0', 'EPL-2.0',
    'GPL-2.0-with-classpath-exception', 'GPL-2.0', 'GPL-3.0', 'LGPL-2.1+', 'LGPL-2.1', 'LGPL-3.0', 'LGPL', 'MIT',
    'MPL-1.1', ]>

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