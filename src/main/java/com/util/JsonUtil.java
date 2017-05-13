package com.util;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

public class JsonUtil {

	public static JSONObject bean2Json(Object obj) {
		return JSONObject.fromObject(obj);
	}

	public static JSONObject map2Json(Map<?, ?> map) {
		return JSONObject.fromObject(map);
	}

	public static JSONObject List2Json(List<?> list) {
		return JSONObject.fromObject(list);
	}

	public static JSONObject Array2Json(Object obj) {
		return JSONObject.fromObject(obj);
	}
}
