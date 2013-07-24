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

<%@ page import="com.liferay.portal.kernel.dao.search.TextSearchEntryExt" %>

<%

String colorTypes = preferences.getValue("colorTypes", com.liferay.portal.util.PropsUtil.getProperties().getProperty("calendar.event.types.color"));

if (colorTypes.equals("*")) {
	StringBuffer stb = new StringBuffer(100);
	//String[] astmp = ((String) CalEventConstants.TYPES[i]).split(",");
	for (String stmp : CalEventConstants.TYPES) {
		stb.append(stmp);
		stb.append("::#000000::#FFFFFF::");
	}
	colorTypes = stb.substring(0, stb.length()-2);
}
		 
boolean hiddenHoursCalendarDay = GetterUtil.getBoolean(preferences.getValue("hiddenHoursCalendarDay", "false"));

int initialHourToHidden = GetterUtil.getInteger(preferences.getValue("initialHourToHidden", "0"));
int finalHourToHidden = GetterUtil.getInteger(preferences.getValue("finalHourToHidden", "6"));

%>


