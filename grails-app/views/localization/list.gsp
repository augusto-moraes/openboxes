
<%@ page import="org.pih.warehouse.core.Localization" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="custom" />
    <g:set var="entityName" value="${warehouse.message(code: 'localization.label', default: 'Localization')}" />
    <title><warehouse:message code="default.list.label" args="[entityName]" /></title>
    <!-- Specify content to overload like global navigation links, page titles, etc. -->
    <content tag="pageTitle"><warehouse:message code="default.list.label" args="[entityName]" /></content>
</head>
<body>
    <div class="body">
        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>
        <div class="dialog">


            <div class="button-bar">
                <g:link class="button" action="list"><warehouse:message code="default.list.label" args="[warehouse.message(code:'localizations.label')]"/></g:link>
                <g:link class="button" action="create"><warehouse:message code="default.add.label" args="[warehouse.message(code:'localization.label')]"/></g:link>
                <g:link class="button" action="export"><warehouse:message code="default.export.label" args="[warehouse.message(code:'localizations.label')]"/></g:link>
                <a href="javascript:void(0);" class="button" id="button-upload-localization"><warehouse:message code="default.import.label" args="[warehouse.message(code:'localizations.label')]"/></a>
            </div>

            <g:hasErrors bean="${command}">
                <div class="errors">
                    <g:renderErrors bean="${command}" as="list" />
                </div>
            </g:hasErrors>

            <div class="box">
                <h2><g:message code="default.search.label"/></h2>
                <g:form controller="localization" action="list" method="GET">
                    <table>
                        <tr class="prop">
                            <td class="value" colspan="2">
                                <div style="width: 100px" class="left">
                                <g:selectLocale name="locale" value="${params.locale}" class="chzn-select-deselect"/>
                                </div>
                                <div class="left">
                                    <g:textField name="q" value="${params.q}" class="text medium" size="60"/>
                                    <g:submitButton name="Search" class="button"/>
                                    <g:link controller="localization" action="list" class="button"><g:message code="default.button.clear.label"/></g:link>
                                </div>
                            </td>
                        </tr>
                    </table>
                </g:form>
            </div>

            <div class="box">
                <h2>
                    <g:message code="localization.label"/>
                    <small><g:message code="default.searchResults.label" args="[localizationInstanceTotal]"/></small>
                </h2>
                <table>
                    <thead>
                        <tr>

                            <g:sortableColumn property="id" title="${warehouse.message(code: 'localization.id.label', default: 'Id')}" />

                            <g:sortableColumn property="code" title="${warehouse.message(code: 'localization.code.label', default: 'Code')}" />

                            <g:sortableColumn property="locale" title="${warehouse.message(code: 'localization.locale.label', default: 'Locale')}" />

                            <g:sortableColumn property="text" title="${warehouse.message(code: 'localization.text.label', default: 'Text')}" />

                            <g:sortableColumn property="dateCreated" title="${warehouse.message(code: 'localization.dateCreated.label', default: 'Date Created')}" />

                            <g:sortableColumn property="lastUpdated" title="${warehouse.message(code: 'localization.lastUpdated.label', default: 'Last Updated')}" />

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${localizationInstanceList}" status="i" var="localizationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                            <td><g:link action="edit" id="${localizationInstance.id}">${fieldValue(bean: localizationInstance, field: "id")}</g:link></td>

                            <td>${fieldValue(bean: localizationInstance, field: "code")}</td>

                            <td>${fieldValue(bean: localizationInstance, field: "locale")}</td>

                            <td>${fieldValue(bean: localizationInstance, field: "text")}</td>

                            <td><format:date obj="${localizationInstance.dateCreated}" /></td>

                            <td><format:date obj="${localizationInstance.lastUpdated}" /></td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="paginateButtons">
                    <g:paginate total="${localizationInstanceTotal}" />
                </div>

            </div>
        </div>
    </div>

    <div id="dialog-localization" class="dialog" style="overflow: visible"
         title="${message(code: 'default.import.label', args: [g.message(code:'localizations.label')])}">
        <g:uploadForm controller="localization" action="upload">
            <g:hiddenField name="id" value="${shipmentInstance?.id}" />
            <table>
                <tbody>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label><warehouse:message code="default.locale.label" /></label>
                    </td>
                    <td valign="top" class="value">
                        <g:selectLocale name="locale" class="chzn-select-deselect" noSelection="['':'']"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label><warehouse:message code="document.selectFile.label" /></label>
                    </td>
                    <td valign="top" class="value">
                        <input name="messageProperties" type="file" />
                    </td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                    <td></td>
                    <td>
                        <g:submitButton name="upload" value="Upload" class="button icon add"></g:submitButton>
                    </td>
                </tr>
                </tfoot>
            </table>
        </g:uploadForm>
    </div>

    <script>

        $(document).ready(function() {

            $("#button-upload-localization").click(function(event){
                $("#dialog-localization").dialog('open');
            });
            $("#dialog-localization").dialog({
                autoOpen: false,
                modal: true,
                width: 600,
                zIndex: 998
            });
        });
    </script>

</body>
</html>
