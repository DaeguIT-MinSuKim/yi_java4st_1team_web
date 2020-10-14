package hairrang_web.utils;

import java.lang.reflect.Type;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;

public class GsonLocalDateTime {

//	public GsonBuilder builder;
//	public DateTimeFormatter formatter;
//	public JsonDeserializer<LocalDateTime> jd;
	
	public static GsonBuilder getLocalDateTimeParsing(String formatStr) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern(formatStr);
		JsonDeserializer<LocalDateTime> jd = new JsonDeserializer<LocalDateTime>() {
			@Override
			public LocalDateTime deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) throws JsonParseException {
				return LocalDateTime.parse(json.getAsString(), formatter);
			}
		};
		return new GsonBuilder().registerTypeAdapter(LocalDateTime.class, jd);
	}
	
}
