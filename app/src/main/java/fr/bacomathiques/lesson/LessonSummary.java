package fr.bacomathiques.lesson;

import org.json.JSONException;
import org.json.JSONObject;

import fr.bacomathiques.util.Utils;

/**
 * Represents a lesson's summary.
 */

public class LessonSummary {

	/**
	 * The API base URL.
	 */

	public static final String BASE_URL = "https://bacomathiqu.es/";

	/**
	 * The API URL.
	 */

	private static final String API_URL = BASE_URL + "api/v1/";

	/**
	 * The lesson's ID.
	 */

	private String id;

	/**
	 * The lesson's content.
	 */

	private String title;

	/**
	 * The lesson's description.
	 */

	private String description;

	/**
	 * The preview URL.
	 */

	private String preview;

	/**
	 * The placeholder content.
	 */

	private String placeholder;

	/**
	 * Creates a new lesson summary instance.
	 *
	 * @param object The JSON object.
	 *
	 * @throws JSONException If a JSON exception occurs.
	 */

	public LessonSummary(final JSONObject object) throws JSONException {
		this(object.getString("id"), object.getString("title"), Utils.fromHtml(object.getString("excerpt")).toString(), object.getString("preview"), Utils.fromHtml(object.getString("caption")).toString());
	}

	/**
	 * Creates a new lesson summary instance.
	 *
	 * @param id The lesson's ID.
	 * @param title The lesson's title.
	 * @param description The lesson's description.
	 * @param preview The preview URL.
	 * @param placeholder The placeholder content.
	 */

	public LessonSummary(final String id, final String title, final String description, final String preview, final String placeholder) {
		this.id = id;
		this.title = title;
		this.description = description;
		this.preview = preview;
		this.placeholder = placeholder;
	}

	/**
	 * Returns lessons URL.
	 *
	 * @return Lessons URL.
	 */

	public static String getLessonsURL() {
		return API_URL + "lessons.json";
	}

	/**
	 * Returns the lesson ID.
	 *
	 * @return The lesson ID.
	 */

	public final String getId() {
		return id;
	}

	/**
	 * Sets the lesson ID.
	 *
	 * @param id The lesson ID.
	 */

	public final void setId(final String id) {
		this.id = id;
	}

	/**
	 * Returns the lesson title.
	 *
	 * @return The lesson title.
	 */

	public final String getTitle() {
		return title;
	}

	/**
	 * Sets the lesson title.
	 *
	 * @param title The lesson title.
	 */

	public final void setTitle(final String title) {
		this.title = title;
	}

	/**
	 * Returns the lesson description.
	 *
	 * @return The lesson description.
	 */

	public final String getDescription() {
		return description;
	}

	/**
	 * Sets the lesson description.
	 *
	 * @param description The lesson description.
	 */

	public final void setDescription(final String description) {
		this.description = description;
	}

	/**
	 * Sets the lesson preview.
	 *
	 * @return The lesson preview.
	 */

	public final String getPreview() {
		return preview;
	}

	/**
	 * Sets the lesson preview.
	 *
	 * @param preview The lesson preview.
	 */

	public final void setPreview(final String preview) {
		this.preview = preview;
	}

	/**
	 * Returns the lesson preview URL.
	 *
	 * @return The lesson preview URL.
	 */

	public final String getPreviewURL() {
		return BASE_URL + preview;
	}

	/**
	 * Returns the lesson placeholder.
	 *
	 * @return The lesson placeholder.
	 */

	public final String getPlaceholder() {
		return placeholder;
	}

	/**
	 * Sets the lesson placeholder.
	 *
	 * @param placeholder The lesson placeholder.
	 */

	public final void setPlaceholder(final String placeholder) {
		this.placeholder = placeholder;
	}

	/**
	 * Returns the lesson URL.
	 *
	 * @return The lesson URL.
	 */

	public final String getLessonURL() {
		return API_URL + "content/" + id + ".json";
	}

}
