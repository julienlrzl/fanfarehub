package com.example.projet_fanfarehub.util;

import org.apache.commons.text.StringEscapeUtils;

public class HtmlUtils {
    public static String cleanInput(String value) {
        if (value != null) {
            value = value.replaceAll("\0", "");
            value = StringEscapeUtils.escapeHtml4(value);
        }
        return value;
    }
}