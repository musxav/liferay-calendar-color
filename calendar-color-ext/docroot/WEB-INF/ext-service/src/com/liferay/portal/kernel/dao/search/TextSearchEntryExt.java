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

package com.liferay.portal.kernel.dao.search;

import java.util.Map;

import javax.portlet.PortletURL;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.liferay.portal.kernel.util.HtmlUtil;
import com.liferay.portal.kernel.util.StringBundler;
import com.liferay.portal.kernel.util.Validator;

/**
 * @author Brian Wing Shun Chan
 */
public class TextSearchEntryExt extends TextSearchEntry {

	public TextSearchEntryExt() {

		super();
	}

	public TextSearchEntryExt(String name, String href, String style) {

		super();
		this.setName(name);
		this.setHref(href);
		this.setStyle(style);
	}

	public String getStyle() {

		return this._style;
	}

	@Override
	public void print(PageContext pageContext)
		throws Exception {

		if (this.getHref() == null) {
			pageContext.getOut().print(this.getName());

		}
		else {
			StringBundler sb = new StringBundler();

			sb.append("<a");

			if (this.getData() != null) {
				for (Map.Entry<String, Object> entry : this.getData().entrySet()) {
					String key = entry.getKey();
					String value = String.valueOf(entry.getValue());

					sb.append(" data-");
					sb.append(key);
					sb.append("=\"");
					sb.append(value);
					sb.append("\"");
				}
			}

			sb.append(" href=\"");
			sb.append(HtmlUtil.escape(this.getHref()));
			sb.append("\"");

			if (Validator.isNotNull(this.getTarget())) {
				sb.append(" target=\"");
				sb.append(this.getTarget());
				sb.append("\"");
			}

			if (Validator.isNotNull(this.getTitle())) {
				sb.append(" title=\"");
				sb.append(this.getTitle());
				sb.append("\"");
			}

			if (Validator.isNotNull(this.getStyle())) {
				sb.append(" style=\"");
				sb.append(this.getStyle());
				sb.append("\"");
			}

			sb.append(">");
			sb.append(this.getName());
			sb.append("</a>");

			JspWriter jspWriter = pageContext.getOut();

			jspWriter.print(sb.toString());
		}
	}

	public void setStyle(String style) {

		this._style = style;
	}

	public static SearchEntry newEntry(
		String name, PortletURL href, String style) {

		return (SearchEntry) new TextSearchEntryExt(
			name, href.toString(), style);
	}

	public static SearchEntry newEntry(String name, String href, String style) {

		return (SearchEntry) new TextSearchEntryExt(name, href, style);
	}

	private String _style;

}
