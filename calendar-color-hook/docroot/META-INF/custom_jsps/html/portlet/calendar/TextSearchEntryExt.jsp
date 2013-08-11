
<%

    
    /* Extends class liferay display system */ 
    

    class TextSearchEntryExt extends 
            com.liferay.portal.kernel.dao.search.TextSearchEntry { 
        
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

        //@Override
        public void print(PageContext pageContext)
            throws Exception {

            if (this.getHref() == null) {
                pageContext.getOut().print(this.getName());

            }
            else {
                StringBundler sb = new StringBundler();

                sb.append("<a");

                if (this.getData() != null) {
                    for (Map.Entry<String, Object> entry : 
                           this.getData().entrySet()) {
                        
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

        public SearchEntry newEntry(
            String name, PortletURL href, String style) {

            return (SearchEntry) new TextSearchEntryExt(
                name, href.toString(), style);
        }

        public SearchEntry newEntry(String name, String href, 
               String style) {

            return (SearchEntry) new TextSearchEntryExt(name, href, style);
        }

        private String _style;

    }

%>

