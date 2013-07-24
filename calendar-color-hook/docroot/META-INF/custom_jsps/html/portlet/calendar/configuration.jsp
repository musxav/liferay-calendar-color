<%--
/**
 * Copyright (c) 2000-2012 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>


<script type="text/javascript" src="/html/js/jquery/jquery.js"></script>
<script type="text/javascript" src="/html/js/misc/farbtastic.js"></script>
<link rel="stylesheet" href="/html/css/misc/farbtastic.css" type="text/css" />

<%@page import="com.liferay.util.Encryptor"%>
<%@ include file="/html/portlet/calendar/init.jsp" %>

<%
String tabs2 = ParamUtil.getString(request, "tabs2", "email-from");

String redirect = ParamUtil.getString(request, "redirect");

String emailFromName = ParamUtil.getString(request, "emailFromName", CalUtil.getEmailFromName(preferences, company.getCompanyId()));
String emailFromAddress = ParamUtil.getString(request, "emailFromAddress", CalUtil.getEmailFromAddress(preferences, company.getCompanyId()));

String emailEventReminderSubject = ParamUtil.getString(request, "emailEventReminderSubject", CalUtil.getEmailEventReminderSubject(preferences));
String emailEventReminderBody = ParamUtil.getString(request, "emailEventReminderBody", CalUtil.getEmailEventReminderBody(preferences));

String editorParam = "emailEventReminderBody";
String editorContent = emailEventReminderBody;
%>

<liferay-portlet:renderURL var="portletURL" portletConfiguration="true">
	<portlet:param name="tabs2" value="<%= tabs2 %>" />
	<portlet:param name="redirect" value="<%= redirect %>" />
</liferay-portlet:renderURL>

<liferay-portlet:actionURL portletConfiguration="true" var="configurationURL" />

<aui:form action="<%= configurationURL %>" method="post" name="fm" onSubmit='<%= "event.preventDefault(); " + renderResponse.getNamespace() + "saveConfiguration();" %>'>
	<aui:input name="<%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />
	<aui:input name="tabs2" type="hidden" value="<%= tabs2 %>" />
	<aui:input name="redirect" type="hidden" value="<%= redirect %>" />

	<liferay-ui:tabs
		names="email-from,event-reminder-email,display-settings,cal-types-event,cal-ext-day"
		param="tabs2"
		url="<%= portletURL %>"
	/>

	<liferay-ui:error key="emailFromAddress" message="please-enter-a-valid-email-address" />
	<liferay-ui:error key="emailFromName" message="please-enter-a-valid-name" />
	<liferay-ui:error key="emailEventReminderBody" message="please-enter-a-valid-body" />
	<liferay-ui:error key="emailEventReminderSubject" message="please-enter-a-valid-subject" />

	<c:choose>
		<c:when test='<%= tabs2.equals("email-from") %>'>
			<aui:fieldset>
				<aui:input cssClass="lfr-input-text-container" label="name" name="preferences--emailFromName--" type="text" value="<%= emailFromName %>" />

				<aui:input cssClass="lfr-input-text-container" label="address" name="preferences--emailFromAddress--" type="text" value="<%= emailFromAddress %>" />
			</aui:fieldset>
		</c:when>
		<c:when test='<%= tabs2.equals("event-reminder-email") %>'>
			<aui:fieldset>
				<aui:input label="enabled" name="preferences--emailEventReminderEnabled--" type="checkbox" value="<%= CalUtil.getEmailEventReminderEnabled(preferences) %>" />

				<aui:input cssClass="lfr-input-text-container" label="subject" name="preferences--emailEventReminderSubject--" type="text" value="<%= emailEventReminderSubject %>" />

				<aui:field-wrapper label="body">
					<liferay-ui:input-editor editorImpl="<%= EDITOR_WYSIWYG_IMPL_KEY %>" />

					<aui:input name='<%= "preferences--" + editorParam + "--" %>' type="hidden" />
				</aui:field-wrapper>
			</aui:fieldset>

			<div class="definition-of-terms">
				<h4><liferay-ui:message key="definition-of-terms" /></h4>

				<dl>
					<dt>
						[$EVENT_LOCATION$]
					</dt>
					<dd>
						<liferay-ui:message key="the-event-location" />
					</dd>
					<dt>
						[$EVENT_START_DATE$]
					</dt>
					<dd>
						<liferay-ui:message key="the-event-start-date" />
					</dd>
					<dt>
						[$EVENT_TITLE$]
					</dt>
					<dd>
						<liferay-ui:message key="the-event-title" />
					</dd>
					<dt>
						[$FROM_ADDRESS$]
					</dt>
					<dd>
						<%= HtmlUtil.escape(emailFromAddress) %>
					</dd>
					<dt>
						[$FROM_NAME$]
					</dt>
					<dd>
						<%= HtmlUtil.escape(emailFromName) %>
					</dd>
					<dt>
						[$PORTAL_URL$]
					</dt>
					<dd>
						<%= company.getVirtualHostname() %>
					</dd>
					<dt>
						[$PORTLET_NAME$]
					</dt>
					<dd>
						<%= PortalUtil.getPortletTitle(renderResponse) %>
					</dd>
					<dt>
						[$TO_ADDRESS$]
					</dt>
					<dd>
						<liferay-ui:message key="the-address-of-the-email-recipient" />
					</dd>
					<dt>
						[$TO_NAME$]
					</dt>
					<dd>
						<liferay-ui:message key="the-name-of-the-email-recipient" />
					</dd>
				</dl>
			</div>
		</c:when>

		<c:when test='<%= tabs2.equals("display-settings") %>'>
			<aui:fieldset label="default-tab">
				<aui:select label="default-tab" name="preferences--tabs1Default--">

					<%
					for (String tabs1Name : tabs1NamesArray) {
					%>

					<aui:option label="<%= tabs1Name %>" selected="<%= tabs1Default.equals(tabs1Name) %>" />

					<%
					}
					%>

				</aui:select>
			</aui:fieldset>

			<aui:fieldset label="summary-tab">
				<aui:select label="summary-tab" name="preferences--summaryTabOrientation--">
					<aui:option label="horizontal" selected='<%= summaryTabOrientation.equals("horizontal") %>' />
					<aui:option label="vertical" selected='<%= summaryTabOrientation.equals("vertical") %>' />
				</aui:select>

				<aui:input label="show-mini-month" name="preferences--summaryTabShowMiniMonth--" type="checkbox" value="<%= summaryTabShowMiniMonth %>" />

				<aui:input label="show-todays-events" name="preferences--summaryTabShowTodaysEvents--" type="checkbox" value="<%= summaryTabShowTodaysEvents %>" />

				<aui:input name="preferences--enableRelatedAssets--" type="checkbox" value="<%= enableRelatedAssets %>" />

				<c:if test="<%= PropsValues.CALENDAR_EVENT_RATINGS_ENABLED %>">
					<aui:input name="preferences--enableRatings--" type="checkbox" value="<%= enableRatings %>" />
				</c:if>

				<c:if test="<%= PropsValues.CALENDAR_EVENT_COMMENTS_ENABLED %>">
					<aui:input name="preferences--enableComments--" type="checkbox" value="<%= enableComments %>" />
				</c:if>
			</aui:fieldset>
		</c:when>
		
		
        <c:when test='<%= tabs2.equals("cal-types-event") %>'>
        
            <aui:input name="preferences--colorTypes--" type="hidden" value="<%= colorTypes %>" />
            <aui:button-row>
                <aui:button type="button" value="cal-type-color-reset" id="resetejar" name="resetejar" onclick="resetejarTipus();" />
            </aui:button-row>
            
            
            <aui:fieldset label="cal-types-event" >
                <aui:select label="" name="TipusIColors" id="TipusIColors" multiple="true" size="7" >
                    <%
                    String[] atmp = colorTypes.split("::");
                    for (int i = 0; i < atmp.length; i += 3) {
                    %> 
                        <option style="foreground-color:<%= atmp[i+1] %>;background-color:<%= atmp[i+2] %>;" 
                            value="<%= atmp[i] %>" onClick="esel()" ><%= atmp[i] %></option>
                    <%
                    }
                    %>

                </aui:select>

                <aui:button-row>
                    <aui:button type="button" value="delete" name="eliminar" id="eliminar" onClick="eliminar();"/>
                </aui:button-row>
                
            </aui:fieldset>
            
            <aui:fieldset label="cal-modify-or-add" >
            
                <input type="hidden" name="colorTinta" id="colorTinta" value="#000000" />
                <input type="hidden" name="colorFons" id="colorFons" value="#ffffff" />
            
            <table>
              <tr>
                <td>
                    <aui:input label="description" name="tipusNou" id="tipusNou" type="text" value="" />
                
                    <aui:input label="cal-color-label" name="color" id="color" type="text" value="#000000::#ffffff" />
                </td>
                <td>            
                    <div id="pickerTinta"></div>
                </td>
                <td>
                    <div id="pickerFons"></div>
                </td>
                <td>
              </tr>
              <tr>
                <td>
                </td>
                <td>
                    <center><liferay-ui:message key="cal-color-foreground" /></center>
                </td>
                <td>
                    <center><liferay-ui:message key="cal-color-Background" /></center>
                </td>
              </tr>
            </table>


            <table>
              <tr>
                <td>
                    <aui:button-row>
                        <aui:button type="button" value="change" id="modificar" name="modificar" onclick="modificar();" />
                    </aui:button-row>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    <aui:button-row>
                        <aui:button type="button" value="add" id="afegir" name="afegir" onclick="afegir();" />
                    </aui:button-row>
                </td>
              </tr>
            </table>

            </aui:fieldset>
            <hr />
          
        </c:when>

		<c:when test='<%= tabs2.equals("cal-ext-day") %>'>

			<aui:fieldset label="cal-ext-day-title">

				<aui:input label="cal-hidden-hours" name="preferences--hiddenHoursCalendarDay--" type="checkbox" value="<%= hiddenHoursCalendarDay %>" />

				<aui:input label="cal-initial-hour-to-hidden" name="preferences--initialHourToHidden--" size="2" type="text" value="<%= initialHourToHidden %>" />

				<aui:input label="cal-end-hour-to-hidden" name="preferences--finalHourToHidden--" size="2" type="text" value="<%= finalHourToHidden %>" />

			</aui:fieldset>
		</c:when>


	</c:choose>

	<aui:button-row>
		<aui:button type="submit" />
	</aui:button-row>
</aui:form>

<aui:script>
	function <portlet:namespace />initEditor() {
		return "<%= UnicodeFormatter.toString(editorContent) %>";
	}

	function <portlet:namespace />saveConfiguration() {
	
		<c:if test='<%= tabs2.equals("event-reminder-email") %>'>
			document.<portlet:namespace />fm.<portlet:namespace /><%= editorParam %>.value = window.<portlet:namespace />editor.getHTML();
		</c:if>

		submitForm(document.<portlet:namespace />fm);
	}
</aui:script>

<aui:script>

    $(document).ready(function() {
        $('#pickerFons').farbtastic('#colorFons').mouseup(function (){
            $('#<portlet:namespace />color').val($('#colorTinta').val() + '::' + $('#colorFons').val());
            $('#<portlet:namespace />color').css("background-color",$.farbtastic('#pickerFons').color);      
        });
        $('#pickerTinta').farbtastic('#colorTinta').mouseup(function (){
            $('#<portlet:namespace />color').val($('#colorTinta').val() + '::' + $('#colorFons').val());
            $('#<portlet:namespace />color').css("color",$.farbtastic('#pickerTinta').color);      
        });
    });

</aui:script>

<aui:script>

    function resetejarTipus() {
        var stmp = '<%= com.liferay.portal.util.PropsUtil.getProperties().getProperty("calendar.event.types.color")%>';
        $('#<portlet:namespace />colorTypes').val(stmp);
        submitForm(document.<portlet:namespace />fm)
    }
 
    function esel() {

        $('#<portlet:namespace />tipusNou').val($('#<portlet:namespace />TipusIColors option:selected').val());
        var iPos = $('#<portlet:namespace />colorTypes').val().indexOf(
                        $('#<portlet:namespace />TipusIColors option:selected').val()) + 
                        $('#<portlet:namespace />TipusIColors option:selected').val().length;
        var cTinta = $('#<portlet:namespace />colorTypes').val().substring(iPos+2, iPos+9);
        var cFons = $('#<portlet:namespace />colorTypes').val().substring(iPos+11, iPos+18);
        
        $('#<portlet:namespace />color').val(cTinta + '::' + cFons);
        $('#<portlet:namespace />color').css('color', cTinta);
        $('#<portlet:namespace />color').css('background', cFons);
        $('#colorTinta').css('background', cTinta);
        $('#colorFons').css('background', cFons);
        $.farbtastic('#pickerTinta').setColor(cTinta);
        $.farbtastic('#pickerFons').setColor(cFons);
    }

    function eliminar() {

        var opt = $('#<portlet:namespace />TipusIColors option:selected').val();
        var act = $('#<portlet:namespace />colorTypes').val();
        act = act.substring(0, act.indexOf(opt)) + 
                  act.substring(act.indexOf(opt) + opt.length + 20);
        if (act.substring(act.length-2) == '::') {
          act = act.substring(0, act.length-2);
        }
        $('#<portlet:namespace />colorTypes').val(act);
        $('#<portlet:namespace />TipusIColors option:selected').remove();
    }

    function afegir() {
        
        $('#<portlet:namespace />TipusIColors').append(
                '<option style="color:' + 
                $('#<portlet:namespace />color').val().substring(0,7) + 
                ';background-color:' +  
                $('#<portlet:namespace />color').val().substring(9,17)  + 
                ';" onClick="esel()" value="' +
                $('#<portlet:namespace />tipusNou').val() + '" >' +
                $('#<portlet:namespace />tipusNou').val() + '</option>');
        $('#<portlet:namespace />colorTypes').val(
                $('#<portlet:namespace />colorTypes').val() + '::' + 
                $('#<portlet:namespace />tipusNou').val() + '::' +
                $('#<portlet:namespace />color').val());
        $('#<portlet:namespace />tipusNou').val('');
    }
    
    function modificar() {
        
        var sct = $('#<portlet:namespace />colorTypes').val();
        var opt = $('#<portlet:namespace />TipusIColors option:selected').val();
        sct = sct.substring(0, sct.indexOf(opt)) +
                $('#<portlet:namespace />tipusNou').val() + '::' +
                $('#<portlet:namespace />color').val() +
                sct.substring(sct.indexOf(opt) + opt.length + 18, sct.length);
        $('#<portlet:namespace />TipusIColors option:selected').html(
                '<option style="background-color:' +
                $('#<portlet:namespace />color').val() + 
                ';" onClick="esel()" value="' +
                $('#<portlet:namespace />tipusNou').val() + '" >' +
                $('#<portlet:namespace />tipusNou').val() + '</option>');
        $('#<portlet:namespace />colorTypes').val(sct);
        $('#<portlet:namespace />tipusNou').val('');
    }
    
</aui:script>


<%!
public static final String EDITOR_WYSIWYG_IMPL_KEY = "editor.wysiwyg.portal-web.docroot.html.portlet.calendar.configuration.jsp";
%>